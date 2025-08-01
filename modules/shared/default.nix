{ lib, pkgs, ... }: {
  imports = [
    ./nix.nix
    ./security.nix
    # Samba shares
    ./ha-config.nix
    ./pwnyboy-media.nix
  ];

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  documentation = {
    nixos.enable = true;
    man.generateCaches = true;
  };

  programs = {
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      package = pkgs.unstable.nix-index-with-db;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 5";
      };
      flake = "/home/mm/.config/home-manager";
    };

    ssh.extraConfig = # sshconf
      ''
        SendEnv TMUX ZELLIJ TERM_PROGRAM
      '';
  };

  environment.systemPackages = with pkgs; [
    age
    lsof
    mosh
    psmisc
    sops
    usbutils

    unstable.comma-with-db
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
    gnupg.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/gpgkey" ];
  };
}
