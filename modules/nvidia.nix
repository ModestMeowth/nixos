{ den, ... }:
{
  den.aspects.nvidia = {
    includes = [
      (den._.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ];

    nixos =
      { config, lib, ... }:
      let
        docker = config.virtualisation.docker;
      in
      {
        hardware = {
          nvidia = {
            open = lib.mkDefault true;
            powerManagement.enable = lib.mkDefault true;
          };

          nvidia-container-toolkit.enable = lib.mkDefault docker.enable;
        };

        services.xserver.videoDrivers = [ "nvidia" ];
      };
  };
}
