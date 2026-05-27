{ ezModules, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };

    hostPlatform = "x86_64-linux";
  };

  hardware = {
    facter = {
      enable = true;
      reportPath = ./facter.json;
    };

    amdgpu.initrd.enable = true;
    graphics.enable32Bit = true;
  };

  networking.hostName = "rocinante";

  fileSystems = {
    "/" = {
      device = "zroot/rocinante/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/nix" = {
      device = "zroot/rocinante/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/persist/etc" = {
      device = "zroot/persist/etc";
      fsType = "zfs";
      neededForBoot = true;
      options = [ "zfsutil" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B360-BBD9";
      fsType = "vfat";
      options = [
        "fmask=0177"
        "dmask=0077"
      ];
    };
  };

  imports = with ezModules; [
    desktop
    docker
    efi
    flatpak
    gaming
    kmscon
    laptop
    hyprland
    shares
    secureboot
    tailscale
    wireless
    yubikey
    zfs

    ./secrets.nix
  ];

  programs = {
    kdeconnect.enable = true;
    nix-ld.enable = true;
    wireshark = {
      enable = true;
      dumpcap.enable = true;
      usbmon.enable = true;
    };
    yubikey-manager.enable = true;
  };

  services = {

    fwupd.enable = true;

    kmscon.extraConfig = ''
      mode=1920x1200
    '';

    sanoid.datasets = {
      "zroot/persist/home/mm".use_template = [ "default" ];
      "zroot/persist/home/root".use_template = [ "default" ];
    };

    xserver.videoDrivers = [ "amdgpu" ];
  };

  shares.pwnyboy-media = {
    enable = true;
    mountpoint = "/persist/media";
  };
}
