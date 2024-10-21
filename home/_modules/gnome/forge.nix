{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wm.gnome.forge;
in
{
  options.modules.wm.gnome.forge.enable = mkEnableOption "gnome-forge";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.gnomeExtensions.forge ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "forge@jmmaranan.com" ];
  };
}
