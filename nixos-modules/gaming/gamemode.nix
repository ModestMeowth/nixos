{ config, lib, ... }:
let
  cfg = config.gaming;
in
{
  config = lib.mkIf (cfg.emulation || cfg.steam || cfg.wine) {
    programs = {
      gamemode.enable = true;
      gamemode.settings.general.desiredgov = "performance";
      gamemode.settings.general.inhibit_screensaver = 1;
    };
  };
}
