{ config, lib, ... }:
let
  docker = config.virtualisation.docker;
in
{
  boot.extraModprobeConfig = "options nvidia NVreg_UsePageAttributeTable=1";
  hardware = {

    nvidia = {
      modesetting.enable = true;
      open = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
    };

    nvidia-container-toolkit.enable = lib.mkDefault docker.enable;
  };
}
