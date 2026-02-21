{config, lib, pkgs, ...}:
let
  docker = config.virtualisation.docker;
in
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = lib.mkDefault true;
    };

    nvidia-container-toolkit.enable = lib.mkDefault docker.enable;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
