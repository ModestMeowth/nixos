{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.gpu == "intel") {
    boot.initrd.kernelModules = ["i915"];
    services.xserver.videoDrivers = ["modesetting"];
    hardware.opengl.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    environment.variables.VDPAU_DRIVER = "va_gl";
  };
}
