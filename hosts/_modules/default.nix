{ config, lib, pkgs, ... }: {
  imports = [
    ./console.nix
    ./gaming
    ./libvirt.nix
    ./monitoring.nix
    ./secureboot.nix
    ./services
    ./shares
    ./wm
    ./wifi-profiles.nix
    ./zfs.nix
  ];

  documentation.nixos.enable = false;
  system.stateVersion = "24.11";

  nix = {
    channel.enable = false;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    settings.substituters = [
      "https://cache.pwnyboy.com"
    ];

    settings.trusted-public-keys = [
      "cache.pwnyboy.com:hoTaHPttKEg3JggxA5rvlcx569zNhUsl8XTc5t7Xhj4="
    ];
  };

  programs = {
    nh.enable = true;
    nh.clean.enable = true;
    nh.clean.extraArgs = "--keep-since 4d --keep 5";
  };

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

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
    fish.enable = true;
    git.enable = true;
    tmux.enable = true;

    ssh.extraConfig = #sshconf
      ''
        SendEnv TMUX ZELLIJ
      '';

    vim.defaultEditor = true;
    vim.enable = true;
  };

  environment.systemPackages = with pkgs; [
    age
    sops
    nvfetcher
    psmisc
    pciutils
    usbutils
    lsof
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
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
}
