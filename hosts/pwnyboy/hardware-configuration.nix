{ config, lib, modulesPath, ... }:
{
  imports = ["${modulesPath}/installer/scan/not-detected.nix"];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "zroot/pwnyboy/root";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/nix" = {
      device = "zroot/pwnyboy/nix";
      fsType = "zfs";
      options = ["zfsutil"];
    };

    "/persist/etc" = {
      device = "zroot/persist/etc";
      fsType = "zfs";
      options = ["zfsutil"];
      neededForBoot = true;
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/F8B6-B30E";
      fsType = "vfat";
      options = [ "fmask=0177" "dmask=0077" ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
