{ezModules, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "thoughtpolice";

  imports = with ezModules; [
    builder
    desktop
    docker
    efi
    gaming
    hyprland
    kmscon
    nvidia
    secureboot
    shares
    tailscale
    unstable
    wireless
    zfs

    ./hardware-configuration.nix
    ./secrets.nix
  ];

  boot = {
    loader.systemd-boot.consoleMode = "3";
    kernelParams = [ "video=efifb:3440x1440-bgr" ];
    plymouth.extraConfig = "DeviceScale=1";
  };

  gaming = {
    emulation = true;
    lutris = true;
    steam = true;
    wine = true;
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

    pcscd.enable = true;
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
