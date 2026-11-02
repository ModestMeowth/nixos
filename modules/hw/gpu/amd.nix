{lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.hw.gpu._.amd = {
    nixos = {
      nixpkgs.config.rocmSupport = mkDefault true;

      hardware.amdgpu = {
        initrd.enable = mkDefault true;
        opencl.enable = mkDefault true;
      };

      services.xserver.videoDrivers = [ "amdgpu" ];
    };

    homeManager = {
      nixpkgs.config.rocmSupport = mkDefault true;
    };
  };
}
