{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.wm.gnome.no-overview;
in
{
  options.modules.wm.gnome.no-overview.enable = mkEnableOption "gnome-no-overview";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.gnomeExtensions.no-overview ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "no-overview@fthx" ];
  };
}
