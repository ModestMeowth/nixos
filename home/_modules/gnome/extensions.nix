{ lib, osConfig, pkgs, ... }:
let
  cfg = osConfig.services.xserver.desktopManager.gnome;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dracula-theme
      dracula-icon-theme
    ] ++ (with pkgs.gnomeExtensions; [
      forge
      gsconnect
      no-overview
      user-themes
    ]);

    gtk.theme.name = "Dracula";
    gtk.iconTheme.name = "Dracula";

    dconf.settings."org/gnome/shell".enabled-extensions = [
      "forge@jmmaranan.com"
      "gsconnect@andyholmes.github.io"
      "no-overview@fthx"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ];

    dconf.settings."org/gnome/shell/extensions/user-theme".name = "Dracula";
  };
}
