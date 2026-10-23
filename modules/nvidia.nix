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
            dynamicBoost.enable = lib.mkDefault true;
            package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs (old: {
              postFixup = (old.postFixup or "") + ''
                for orig in $bin/origBin/*; do
                  f=$bin/bin/$(basename $orig)
                  rp=$(patchelf --print-rpath $f); int=$(patchelf --print-interpreter $f)
                  install -m755 $orig $f
                  patchelf --set-rpath "$rp" $f
                  patchelf --interpreter "$int" $f
                done
              '';
            });
          };

          nvidia-container-toolkit.enable = lib.mkDefault docker.enable;
        };

        services.xserver.videoDrivers = [ "nvidia" ];
      };
  };
}
