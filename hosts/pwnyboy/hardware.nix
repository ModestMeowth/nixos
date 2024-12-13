{config, lib, modulesPath, ...}: {
  imports = [("${modulesPath}/installer/scan/not-detected.nix")];

  modules.hw.cpu = "intel";
  modules.hw.gpu.intel.enable = true;
  modules.hw.zfs.enable = true;

#  modules.hw.secureboot.enable = true;

  boot.initrd.availableKernelModules = ["nvme"];

  boot.kernelModules = ["acpi_call"];

  boot.extraModulePackages = with config.boot.kernelPackages; [acpi_call];

  boot.kernelParams = ["quiet"];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub.enable = lib.mkForce false;
    timeout = 3;
  };
}
