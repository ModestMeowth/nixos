{ config
, lib
, modulesPath
, ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  modules.hw.cpu = "amd";
  modules.hw.gpu.amd.enable = true;
  modules.hw.secureboot.enable = true;
  modules.hw.zfs.enable = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [ "acpi_call" ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  boot.kernelParams = [ "quiet" ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub.enable = lib.mkForce false;
    timeout = 3;
  };
}
