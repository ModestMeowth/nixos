{ config, lib, pkgs, ... }: {
  imports = [
    ./nix.nix

    ./console.nix
    ./gaming
    ./monitoring
    ./mosh.nix
    ./services
    ./shares
    ./wifi-profiles.nix
  ];

  documentation = {
    nixos.enable = false;

    man.generateCaches = true;
  };

  system.stateVersion = "25.05";

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
  };

  networking = {
    nftables.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    firewall.allowedUDPPortRanges = [{
      # Mosh
      from = 60000;
      to = 61000;
    }];
  };

  programs = {
    nh.enable = true;
    nh.clean.enable = true;
    nh.clean.extraArgs = "--keep-since 4d --keep 5";

    nix-index-database.comma.enable = true;
    nix-index.enable = true;
    nix-index.package = pkgs.unstable.nix-index;
    command-not-found.enable = false;

    fish.enable = true;
    git.enable = true;
    tmux.enable = true;

    ssh.extraConfig = #sshconf
      ''
        SendEnv TMUX ZELLIJ TERM_PROGRAM
      '';

    vim.defaultEditor = true;
    vim.enable = true;
  };

  environment.systemPackages = with pkgs; [
    age
    home-manager
    lsof
    nvfetcher
    psmisc
    sops
    usbutils
    sbctl # Need for setting up secureboot, before enabling lanzaboote
  ];

  sops = {
    defaultSopsFile = ../global.sops.yaml;
    age.generateKey = true;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
    gnupg.sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/gpgkey" ];
  };

  security = {
    pam.loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "5424288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];

    sudo.enable = true;
    sudo.wheelNeedsPassword = true;
  };

  boot.loader.systemd-boot.enable = lib.mkDefault (!config.wsl.enable);
}
