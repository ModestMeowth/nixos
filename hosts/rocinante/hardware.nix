{ config, modulesPath, pkgs, ... }: {
  imports = [ ("${modulesPath}/installer/scan/not-detected.nix") ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12; # zfs does not support 6.13 as of 2025-01-27

    lanzaboote.enable = true;

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];
  };

  # Plymouth
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];

  hardware = {
    cpu.amd.updateMicrocode = true;

    graphics.enable = true;
    graphics.enable32Bit = true;

    amdgpu.initrd.enable = true;
    amdgpu.amdvlk.enable = true;
    amdgpu.amdvlk.support32Bit.enable = true;
    amdgpu.amdvlk.supportExperimental.enable = true;
    amdgpu.opencl.enable = true;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
  };
}
