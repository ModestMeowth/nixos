{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.gaming.lutris;
  steam = if osConfig.programs.steam.enable then osConfig.programs.steam.package else pkgs.steam;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [ "net.lutris.Lutris" ];

    programs.lutris = lib.mkIf (!cfg.flatpak) {
      enable = true;
      steamPackage = steam;
    };
  };
}
