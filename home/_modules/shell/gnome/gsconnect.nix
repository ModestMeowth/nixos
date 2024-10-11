{config, lib, pkgs, ...}: {
  options.hm-mm.shell.gnome.gsconnect = lib.mkEnableOption "gnome-gsconnect";

  config = lib.mkIf config.hm-mm.shell.gnome.gsconnect {
    home.packages = [ pkgs.gnomeExtensions.gsconnect ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "gsconnect@andyholms.github.io" ];
  };
}
