{ modulesPath, pkgs, ... }: {
  imports = [ ("${modulesPath}/installer/scan/not-detected.nix") ];

  boot.lanzaboote.enable = false;
  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = ["kvm-intel"];

  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-vaapi-driver
    intel-ocl
    intel-media-driver
    intel-compute-runtime
    vpl-gpu-rt
  ];

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}
