{ config, lib, ... }:
let
  cfgRetroarch = config.gaming.emulation.enable;
  cfgSteam = config.gaming.steam.enable;
  cfgWine = config.gaming.wine.enable;
in
{
  programs.gamemode = lib.mkIf (cfgRetroarch || cfgSteam || cfgWine) {
    enable = true;
    settings.general = {
      desiredgov = "performance";
      inhibit_screensaver = 1;
    };
  };
}
