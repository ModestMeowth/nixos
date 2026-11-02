{lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.hw.gpu.intel = {
    nixos =
      {pkgs, ...}:
      {
        hardware.graphics = {
          enable = true;
          extraPackages = with pkgs; [
            intel-media-driver
            intel-compute-runtime
            vpl-gpu-rt
          ];
        };

        environment.sessionVariables.LIBVA_DRIVER_NAME = mkDefault "iHD";
      };

    homeManager = {
      
    };
  };
}
