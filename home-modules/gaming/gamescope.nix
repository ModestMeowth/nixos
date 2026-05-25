{ config, lib, ... }:
let
  cfg = config.services.flatpak;
in
{
  services.flatpak.packages = lib.mkIf cfg.enable [ "org.freedesktop.Platform.VulkanLayer.gamescope//25.08" ];
}
