{config, lib, pkgs, ...}: {
  options.hm-mm.shell.gnome.no-overview = lib.mkEnableOption "gnome-no-overview";

  config = lib.mkIf config.hm-mm.shell.gnome.no-overview {
    home.packages = [ pkgs.gnomeExtensions.no-overview ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "no-overview@fthx" ];
  };
}
