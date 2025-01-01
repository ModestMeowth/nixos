{config, lib, pkgs, ...}: let
  cfgRetroarch = config.gaming.retroarch.enable;
  cfgSteam = config.gaming.steam.enable;
  cfgWine = config.gaming.wine.enable;
in {
  programs.gamemode = lib.mkIf (cfgRetroarch || cfgSteam || cfgWine) {
    enable = true;
  };
}
