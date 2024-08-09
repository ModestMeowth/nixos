{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.gpu == "amd") {
    boot.initrd.kernelModules = ["amdgpu"];
    services.xserver.videoDrivers = ["amdgpu"];
    hardware.opengl.extraPackages = with pkgs;
      [
        amdvlk
      ]
      ++ (with rocmPackages; [
        clr
        rocm-runtime
      ]);
    environment.variables.AMD_VULKAN_ICD = "RADV";
  };
}
