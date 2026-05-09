{ ezModules, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.distributedBuilds = false;

  imports = with ezModules; [
    appimage
    builder
    desktop
    docker
    efi
    flatpak
    gaming
    hyprland
    kmscon
    mdns
    nvidia
    secureboot
    shares
    tailscale
    yubikey
    zfs

    ./hardware-configuration.nix
    ./secrets.nix
  ];

  boot = {
    loader.systemd-boot.consoleMode = "3";
    kernelParams = [ "video=efifb:3440x1440-bgr" ];
    plymouth.extraConfig = "DeviceScale=1";
    kernelModules = [ "sg" ];
  };

  networking = {
    hostName = "thoughtpolice";
    useDHCP = true;
  };

  programs = {
    kdeconnect.enable = true;
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
    yubikey-manager.enable = true;
  };

  services = {
    fwupd.enable = true;

    power-profiles-daemon.enable = true;

    sanoid.datasets = {
      "zroot/persist/home/mm".use_template = [ "default" ];
      "zroot/persist/home/root".use_template = [ "default" ];
    };
  };

  shares.pwnyboy-media = {
    enable = true;
    mountpoint = "/persist/media";
  };
}
