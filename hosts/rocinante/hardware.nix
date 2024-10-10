{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [
      "acpi_call"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

    kernelParams = [
      "quiet"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub.enable = lib.mkForce false;
      timeout = 3;
    };
  };

  fileSystems = {
    "/" = {
      device = "zroot/root";
      fsType = "zfs";
    };

    "/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
    };

    "/persist" = {
      device = "zroot/persist";
      fsType = "zfs";
    };

    "/persist/k8s" = {
      device = "zroot/persist/k8s";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7785953DEF-part1";
      fsType = "vfat";
      options = [
        "defaults"
        "umask=0077"
      ];
    };

    "/home" = {
      device = "zroot/home";
      fsType = "zfs";
    };
  };
}
