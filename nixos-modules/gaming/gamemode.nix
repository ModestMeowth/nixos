{ config, lib, ... }:
let
  cfg = config.gaming.gamemode;
in
{
    programs = lib.mkIf cfg {
      gamemode.enable = true;
      gamemode.settings.general.desiredgov = "performance";
      gamemode.settings.general.inhibit_screensaver = 1;
    };
}
