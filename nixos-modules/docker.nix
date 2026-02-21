{ config, lib, ... }:
let
  rootless = config.virtualisation.docker.rootless;
  nvidia = config.hardware.nvidia-container-toolkit;
in
{
  virtualisation.docker = {
    enable = lib.mkDefault true;
    autoPrune = {
      enable = lib.mkDefault true;
      flags = lib.mkDefault [ "--all" ];
    };

    daemon.settings.features.cdi = (nvidia.enable  && ! rootless.enable);
    rootless.daemon.settings.features.cdi = (nvidia.enable && rootless.enable);
  };
}
