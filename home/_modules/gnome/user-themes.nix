{config, lib, pkgs, ...}: with lib; let
  cfg = config.modules.wm.gnome.user-themes;
in {
  options.modules.wm.gnome.user-themes.enable = mkEnableOption "gnome-user-themes";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.gnomeExtensions.user-themes ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
  };
}
