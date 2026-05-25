{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.gaming.steam;
  osCfg = osConfig.programs.steam;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [ "com.valvesoftware.Steam" ];

    home.packages = lib.mkIf (!osCfg.enable && !cfg.flatpak) [ pkgs.steam ];
  };
}
