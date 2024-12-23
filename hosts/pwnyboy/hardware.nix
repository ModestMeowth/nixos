{ lib, modulesPath, pkgs, ... }: {
  imports = [
    ("${modulesPath}/installer/scan/not-detected.nix")
    ./i915-sriov.nix
  ];

  boot.lanzaboote.enable = true;

  # random-seed prevents boot on this particular nvme...
  systemd.services."systemd-boot-random-seed".enable = lib.mkForce false;
  systemd.services."systemd-random-seed".enable = lib.mkForce false;

  hardware.cpu.intel.updateMicrocode = true;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.kernelModules = [
    "kvm-intel"
    "vfio_virqfd"
    "vfio_pci"
  ];

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

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
