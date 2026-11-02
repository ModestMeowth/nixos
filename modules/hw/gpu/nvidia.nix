{den, lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.hw.gpu.nvidia =
    {
    includes = [
      (den._.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ];

    nixos =
      { config, ... }:
      let
        docker = config.virtualisation.docker;
      in
      {
        nixpkgs.config.cudaSupport = mkDefault true;

        hardware = {
          nvidia = {
            open = mkDefault true;
            powerManagement.enable = mkDefault true;
            dynamicBoost.enable = mkDefault true;
          };

          nvidia-container-toolkit.enable = mkDefault docker.enable;
        };

        environment.variables.LIBVA_DRIVER_NAME = "nvidia";

        services.xserver.videoDrivers = [ "nvidia" ];
      };

    homeManager = {
      nixpkgs.config.cudaSupport = mkDefault true;
    };
  };
}
