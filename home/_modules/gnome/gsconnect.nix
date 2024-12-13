{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.wm.gnome.gsconnect;
in
{
  options.modules.wm.gnome.gsconnect.enable = mkEnableOption "gnome-gsconnect";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.gnomeExtensions.gsconnect ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "gsconnect@andyholmes.github.io" ];
  };
}
