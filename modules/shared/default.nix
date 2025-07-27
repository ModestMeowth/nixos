{ lib, pkgs, ... }: {
  imports = [
    ./nix.nix
    ./firewall.nix
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
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 5";
      };
    };

    nix-index-database.comma.enable = true;

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
    usbutils
    sops
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
    gnupg.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/gpgkey" ];
  };
}
