{config, modulesPath, pkgs, ...}: {
  imports = [("${modulesPath}/installer/scan/not-detected.nix")];

  boot.lanzaboote.enable = false;
  hardware.cpu.intel.updateMicrocode = true;
  boot.initrd.kernelModules = ["xe"];

  boot.kernelModules = [];
  boot.extraModulePackages = with config.boot.kernelPackages; [];

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
