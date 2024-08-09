{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.gpu == "nvidia") {
    boot.initrd.kernelModules = ["nvidia"];
    boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      opengl.extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
      };
    };
    environment.variables = {
      VDPAU_DIREVER = "va_gl";
      LIBVA_DRIVER_NAME = "nvidia";
    };
  };
}
