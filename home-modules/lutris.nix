{lib, osConfig, pkgs, ...}:
let
  osSteam = osConfig.programs.steam;
in
{
  programs.lutris = {
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
