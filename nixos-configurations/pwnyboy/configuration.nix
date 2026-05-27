{
  config,
  ezModules,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  nix.distributedBuilds = false;

  fileSystems = {
    "/" = {
      device = "zroot/pwnyboy/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/nix" = {
      device = "zroot/pwnyboy/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/persist/etc" = {
      device = "zroot/persist/etc";
      fsType = "zfs";
      options = [ "zfsutil" ];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/F8B6-B30E";
      fsType = "vfat";
      options = [
        "fmask=0177"
        "dmask=0077"
      ];
    };
  };

  hardware.facter = {
    enable = true;
    reportPath = ./facter.json;
  };

  imports = with ezModules; [
    builder
    cockpit
    docker
    efi
    kmscon
    ncps
    secureboot
    tailscale
    zfs

    ./secrets.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "sr_mod" ];
    kernelModules = [
      "vfio_virqfd"
      "vfio_pci"
    ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
    zfs.extraPools = [
      "docker"
      "persist"
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  hardware = {
    graphics.enable = true;
    graphics.extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-ocl
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  networking = {
    hostName = "pwnyboy";
    nameservers = [ "192.168.1.1" ];
    search = [ "threefinger.farm" ];
    useDHCP = false;

    bridges = {
      bridge0.interfaces = [ "enp3s0" ];

      bridge1.interfaces = [ "enp4s0" ];
    };

    interfaces = {
      enp3s0.wakeOnLan.enable = true;
      enp4s0.wakeOnLan.enable = true;
      bridge0.ipv4.addresses = [
        {
          address = "192.168.1.30";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "bridge0";
    };

    firewall = {
      allowedTCPPorts = [
        443
        8081
        8083
        8123

        8883
        22000
      ];

      allowedUDPPorts = [
        22000
        21027
      ];
    };
  };

  power.ups = {
    enable = true;
    mode = "netserver";
    openFirewall = true;

    upsd.listen = [
      { address = "0.0.0.0"; }
      { address = "::"; }
    ];

    users."ha".passwordFile = config.sops.secrets."ha-nut-user".path;

    ups."network" = {
      driver = "usbhid-ups";
      description = "Networking UPS";
      port = "auto";
      directives = [
        "vendorid = 0764"
        "productid = 0501"
      ];
    };

    upsmon.monitor."network" = {
      system = "network@192.168.1.30";
      user = "ha";
      passwordFile = config.sops.secrets."ha-nut-user".path;
    };
  };

  services = {
    cockpit.allowed-origins = [
      "https://pwnyboy:9090"
      "https://pwnyboy.threefinger.farm"
      "https://pwnyboy.cat-alkaline.ts.net:9090"
      "https://pwnyboy.com"
    ];

    fwupd.enable = true;

    samba = {
      enable = true;
      openFirewall = true;

      settings.global = {
        "workgroup" = "WORKGROUP";
        "server string" = "pwnyboy";
        "netbios name" = "pwnyboy";

        "security" = "user";
        "guest account" = "nobody";
        "map to guest" = "bad user";

        "mangled names" = "no";
        "vfs objects" = "catia";
        "catia:mappings" = "0x3a:0x5f";
      };

      settings.media = {
        browsable = "yes";
        comment = "media";
        path = "/persist/data/media";

        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

    sanoid.datasets = {
      "zroot/persist/home/mm".use_template = [ "default" ];
      "zroot/persist/home/root".use_template = [ "default" ];

      "persist/backups/emulation/saves".use_template = [ "default" ];
      "persist/backups/signal".use_template = [ "default" ];
      "persist/cloud/photos".use_template = [ "default" ];
      "persist/data".use_template = [ "default" ];

      "docker/config".use_template = [ "default" ];
    };
  };

  systemd.services = {
    "systemd-boot-random-seed".enable = lib.mkForce false;
    "systemd-random-seed".enable = lib.mkForce false;
  };
}
