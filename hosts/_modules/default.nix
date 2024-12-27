{ config, lib, pkgs, ... }: {
  imports = [
    ./console.nix
    ./libvirt.nix
    ./secureboot.nix
    ./services
    ./shares
    ./wm
    ./wifi-profiles.nix
    ./zfs.nix
  ];

  documentation.nixos.enable = false;
  system.stateVersion = "24.11";

  nix.channel.enable = false;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://pwnyboy.cat-alkaline.ts.net:5000"
    ];

    trusted-public-keys = [
      "pwnyboy.cat-alkaline.ts.net:H5DR+YdP5Pt0OUYG1C1y7d+bFNEePQtjR3XvqUekCgs="
    ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
  };

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.tmux.enable = true;

  programs.ssh.extraConfig = #sshconf
    ''
      SendEnv TMUX ZELLIJ
    '';

  programs.vim = {
    defaultEditor = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    age
    sops
    nvfetcher
    psmisc
    pciutils
    lsof
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.sshKeyPaths = lib.mkDefault ["/persist/etc/sops/agekey"];
    gnupg.sshKeyPaths = lib.mkDefault ["/persist/etc/sops/gpgkey"];
  };

  security.pam.loginLimits = [
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

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
