{ ezModules, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "rocinante";

  imports = with ezModules; [
    desktop
    docker
    efi
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

    ./hardware-configuration.nix
    ./secrets.nix
  ];

  gaming = {
    emulation = true;
    steam = true;
  };

  hardware = {
    amdgpu.initrd.enable = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
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

  virtualisation.docker.package = pkgs.docker_29;
}
