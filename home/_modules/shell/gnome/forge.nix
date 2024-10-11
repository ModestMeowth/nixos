{config, lib, pkgs, ...}: {
  options.hm-mm.shell.gnome.forge = lib.mkEnableOption "gnome-forge";

  config = lib.mkIf config.hm-mm.shell.gnome.forge {
    home.packages = [ pkgs.gnomeExtensions.forge ];

    dconf.settings."org/gnome/shell".enabled-extensions = [ "forge@jmmaranan.com" ];
  };
}
