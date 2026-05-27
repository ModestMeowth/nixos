{ ezModules, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  nix.distributedBuilds = false;

  fileSystems."/" = {
    device = "zroot/thoughtpolice/root";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/nix" = {
    device = "zroot/thoughtpolice/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/persist/etc" = {
    device = "zroot/persist/etc";
    fsType = "zfs";
    neededForBoot = true;
    options = [ "zfsutil" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3B4E-D7BA";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  hardware = {
    facter = {
      enable = true;
      reportPath = ./facter.json;
    };

    graphics.enable32Bit = true;
  };

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
