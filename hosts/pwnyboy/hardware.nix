{ lib, modulesPath, pkgs, ... }: {
  imports = [
    ("${modulesPath}/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_6_14;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-intel"
      "vfio_virqfd"
      "vfio_pci"
    ];

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
}
