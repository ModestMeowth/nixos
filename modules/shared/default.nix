{ lib, pkgs, ... }: {
  imports = [
    ./nix.nix
    ./security.nix
    ./fonts.nix
    ./users.nix
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
    nix-index-database.comma.enable = true;

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
  ];

  systemd.services.numLockOnTty = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = (pkgs.writeShellScript "numLockOnTty" # bash
        ''
          for tty in /dev/tty{1..6}; do
            ${pkgs.kbd}/bin/setleds -D +num < "$tty";
          done
        '');
    };
  };

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
    gnupg.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/gpgkey" ];
  };
}
