{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  cfg = config.gaming;
  osSteam = osConfig.programs.steam;
in
{
  programs.lutris = lib.mkIf cfg.lutris {
    enable = true;
    package = pkgs.lutris;
    steamPackage = lib.mkIf osSteam.enable osSteam.package;
    defaultWinePackage = pkgs.proton-ge-bin;
    extraPackages = with pkgs; [
      dosbox
      gamemode
      umu-launcher
      winetricks
    ];
  };
}
