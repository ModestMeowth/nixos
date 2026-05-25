{ config, lib, ... }:
let
  cfg = config.gaming.wine;
in
{
  services.flatpak.packages = lib.mkIf (cfg.enable && cfg.flatpak) [ "org.winehq.Wine" ];
}
