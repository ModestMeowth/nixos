{ config
, lib
, pkgs
, ...
}:
with lib;
let

  cfg = config.modules.hw.gpu;

in
{

  options.modules.hw.gpu = {
    amd.enable = mkEnableOption "amd-gpu";
    intel.enable = mkEnableOption "intel-gpu";
    nvidia.enable = mkEnableOption "nvidia-gpu";
  };

  config = mkMerge [

    {
      # Defaults
      hardware.opengl = {
        enable = true;
        driSupport = true;
      };

      environment.systemPackages = with pkgs; [
        vulkan-tools
        clinfo
      ];

    }

    (mkIf cfg.amd.enable {
      hardware.amdgpu = {
        initrd.enable = true;
        amdvlk.enable = true;
      };
      services.xserver.videoDrivers = [ "amdgpu" ];
    })

    (mkIf cfg.intel.enable {

      boot.initrd.kernelModules = [ "i915" ];

      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.opengl.extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];

      environment.variables.VDPAU_DRIVER = "va_gl";

    })

    (mkIf cfg.nvidia.enable {

      boot.initrd.kernelModules = [ "nvidia" ];
      boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

      services.xserver.videoDrivers = [ "nvidia" ];

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
        VDPAU_DRIVER = "va_gl";
        LIBVA_DRIVER_NAME = "nvidia";
      };

    })

  ];
}
