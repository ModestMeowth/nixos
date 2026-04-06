{config, lib, ...}:
let
  cfg = config.gaming.gamescope;
in
{
  programs = lib.mkIf cfg {
    gamescope = {
      enable = true;
      capSysNice = lib.mkDefault true;
    };

    steam.gamescopeSession.enable = lib.mkDefault true;
    opengamepadui.gamescopeSession.enable = lib.mkDefault true;
  };
}
