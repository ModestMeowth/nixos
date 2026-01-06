{ lib, modulesPath, pkgs, ... }:
let
  root = "zroot/pwnyboy";
  persist = "zroot/persist";
in {
  imports = [ "${modulesPath}/installer/scan/not-detected.nix" ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];

    kernelModules = [ "kvm-intel" "vfio_virqfd" "vfio_pci" ];

    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "i915.force_probe=!4692"
      "xe.force_probe=4692"
    ];

    lanzaboote.enable = true;
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    graphics.enable = true;
    graphics.extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-ocl
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  systemd = {
    # Random-seed prevents boot on this particular NVME...
    services."systemd-boot-random-seed".enable = lib.mkForce false;
    services."systemd-random-seed".enable = lib.mkForce false;

    # Nixvirt starts before ttyUSB0 is ready
    services."nixvirt" = {
      requires = [ "dev-ttyUSB0.device" ];
      after = [ "dev-ttyUSB0.device" ];
    };
  };

  fileSystems = {
    "/" = {
      device = "${root}/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/nix" = {
      device = "${root}/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

    "/persist/etc" = {
      device = "${persist}/etc";
      fsType = "zfs";
      options = [ "zfsutil" ];
      neededForBoot = true;
    };

    "/boot" = {
      device =
        "/dev/disk/by-id/nvme-INTEL_SSDPEDMW400G4_CVCQ5252008B400AGN-part1";
      fsType = "vfat";
      options = [ "dmask=0077" "fmask=0177" ];
    };
  };

  boot.zfs.extraPools = [ "docker" "persist" ];

  services.sanoid.datasets = {
    "zroot/persist/home/mm".use_template = [ "default" ];
    "zroot/persist/home/root".use_template = [ "default" ];

    "persist/backups/emulation/saves".use_template = [ "default" ];
    "persist/backups/signal".use_template = [ "default" ];
    "persist/cloud/photos".use_template = [ "default" ];
    "persist/data".use_template = [ "default" ];

    "docker/config".use_template = [ "default" ];
  };

  shares = { ha-config.enable = true; };
}
