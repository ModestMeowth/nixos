{config, lib,  modulesPath, ...}:
{
  imports = ["${modulesPath}/installer/scan/not-detected.nix"];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [ "kvm-amd" "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  fileSystems = {
    "/" = {
      device = "zroot/rocinante/root";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/nix" = {
      device = "zroot/rocinante/nix";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/persist/etc" = {
      device = "zroot/persist/etc";
      fsType = "zfs";
      neededForBoot = true;
      options = ["zfsutil"];
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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
