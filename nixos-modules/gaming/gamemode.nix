{ config, lib, ... }:
let
  cfg = config.gaming;
in
{
  programs = lib.mkIf (cfg.emulation || cfg.ffxiv || cfg.steam || cfg.wine) {
    gamemode.enable = lib.mkDefault true;
    gamemode.settings.general.desiredgov = "performance";
    gamemode.settings.general.inhibit_screensaver = 1;
  };
}
