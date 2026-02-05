{ezModules, inputs, pkgs, ...}:
let
  wlan = "wlp2s0";
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote

    ezModules.desktop
    ezModules.efi
    ezModules.gaming
    ezModules.laptop
    ezModules.hyprland
    ezModules.shares
    ezModules.secureboot
    ezModules.tailscale
    ezModules.unstable
    ezModules.zfs

    ./hardware-configuration.nix
    ./secrets.nix
  ];

  boot = {
    kernelParams = ["quiet"];
    plymouth.enable = true;
  };

  gaming = {
    emulation = true;
    steam = true;
  };

  hardware = {
    amdgpu.initrd.enable = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
  };

  networking = {
    hostName = "rocinante";
    networkmanager.ensureProfiles.profiles = {
      "Ponyboy Bounce House".connection.interface-name = wlan;
      "Hyrule".connection.interface-name = wlan;
    };
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
    chrony.enable = true;

    fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-elan;
    };

    fwupd.enable = true;
    pcscd.enable = true;

    sanoid.datasets = {
      "zroot/persist/home/mm".use_template = ["default"];
      "zroot/persist/home/root".use_template = ["default"];
    };

    xserver.videoDrivers = [ "amdgpu" ];
  };

  shares.pwnyboy-media = {
    enable = true;
    mountpoint = "/persist/media";
  };

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
    autoPrune = {
      enable = true;
      flags = ["--all"];
    };
  };
}
