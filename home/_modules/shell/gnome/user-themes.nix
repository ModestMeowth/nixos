{config, lib, pkgs, ...}: {
  options.hm-mm.shell.gnome.user-themes = lib.mkEnableOption "gnome-user-themes";

  config = lib.mkIf config.hm-mm.shell.gnome.user-themes {
    home.packages = [ pkgs.gnomeExtensions.user-themes ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
  };
}
