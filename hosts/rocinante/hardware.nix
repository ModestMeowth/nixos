{ config, modulesPath, pkgs, ... }: {
  imports = [ ("${modulesPath}/installer/scan/not-detected.nix") ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote.enable = true;
  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [ "acpi_call" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

  # Plymouth
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];

  hardware.graphics.enable = true;

  hardware.amdgpu = {
    initrd.enable = true;
    amdvlk.enable = true;
    opencl.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
}
