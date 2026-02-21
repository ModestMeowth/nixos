{config, lib, ...}:
let
  docker = config.virtualisation.docker;
in
{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = lib.mkDefault true;
    modesetting.enable = true;
  };

  hardware.nvidia-container-toolkit = lib.mkDefault docker.enable;
}
