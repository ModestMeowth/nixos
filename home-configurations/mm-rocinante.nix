{ config, ezModules, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  wallpaper = config.stylix.image;
in
{
  home.username = "mm";
  home.homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";

  imports = with ezModules; [
    bootdev
    desktop
    hyprland
    network-utils
    syncthing
    virt-manager
  ];

  home.packages = with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    kdePackages.kcalc
    google-chrome
    signal-desktop
    wireshark
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_options = ctrl:swapcaps
      follow_mouse = 1
    }
  '';

  xdg.configFile = {
    "hypr/hyprland.conf.d/monitor.conf".text = ''
      monitorv2 {
        output = eDP-1
        mode = 1920x1200@60
        vrr = 3
      }
    '';

    "hypr/hyprpaper.conf".text = ''
      wallpaper {
        monitor = eDP-1
        path = ${wallpaper}
        fit_mode = contain
      }

      splash = false
    '';

    "hypr/hyprsunset.conf".text = ''
      profile {
        temperature = 3000
      }
    '';
  };
}
