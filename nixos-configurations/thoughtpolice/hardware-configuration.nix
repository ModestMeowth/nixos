{ config, modulesPath, ... }:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
      "sr_mod"
    ];

    kernelModules = [ "kvm-amd" ];
  };

  fileSystems."/" =
    { device = "zroot/thoughtpolice/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/nix" =
    { device = "zroot/thoughtpolice/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/persist/etc" =
    { device = "zroot/persist/etc";
      fsType = "zfs";
      neededForBoot = true;
      options = [ "zfsutil" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3B4E-D7BA";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  hardware = {
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  };
}
