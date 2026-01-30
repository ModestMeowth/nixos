{
  config,
  pkgs,
  ...
}:
let
  wlan = "wlp2s0";
in
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  boot = {
    initrd.verbose = false;
    kernelParams = [ "quiet" ];
    plymouth.enable = true;
  };

  fleet = {
    isLaptop = true;
    useSecureboot = true;
    useHyprland = true;
    useZfs = true;
  };

  gaming = {
    emulation = true;
    steam = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    amdgpu.initrd.enable = true;
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

    tailscale =
      let
        flags = [
          "--ssh"
          "--operator=mm"
        ];
      in
      {
        enable = true;
        authKeyFile = config.sops.secrets."tskey".path;
        extraUpFlags = flags ++ [ "--reset" ];
        extraSetFlags = flags;
        openFirewall = true;
        useRoutingFeatures = "client";
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
