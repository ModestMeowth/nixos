{ezModules, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "thoughtpolice";

  imports = with ezModules; [
    builder
    desktop
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

  gaming = {
    emulation = true;
    steam = true;
    wine = true;
  };

  hardware.nvidia.open = false;

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
