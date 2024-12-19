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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.log-lines = lib.mkDefault 25;

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

  programs.vim = {
    defaultEditor = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    age
    sops
    nvfetcher
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.keyFile = "/var/lib/sops-nix/key.txt";
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
