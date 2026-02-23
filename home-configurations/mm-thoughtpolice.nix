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

  xdg.configFile = {
    "hypr/hyprland.conf.d/monitor.conf".text = ''
        monitorv2 {
          output = DP-1
          mode = 3440x1440@74.98
          position = 0x0
          vrr = 3
        }

        monitorv2 {
          output = DP-2
          mode =  1920x1080@74.973
          position = 3440x0
          transform = 1
          vrr = 3
        }
      '';

    "hypr/hyprpaper.conf".text = ''
      wallpaper {
        monitor =
        path = ${wallpaper}
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
