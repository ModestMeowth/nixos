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
    lutris
    network-utils
    syncthing
    virt-manager
  ];

  home.packages = with pkgs; [
    bitwarden-desktop
    kdePackages.dolphin
    kdePackages.kcalc
    signal-desktop
    wireshark
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  xdg.configFile = {
    "hypr/hyprland.conf.d/monitor.conf".text = ''
        opengl {
          nvidia_anti_flicker = true
        }

        monitorv2 {
          output = DP-1
          mode = 3440x1440@75
          position = 0x0
        }

        monitorv2 {
          output = HDMI-A-1
          mode =  1920x1080@75
          position = 3440x0
          transform = 1
        }

        workspace = 1, monitor:DP-1
        workspace = 2, monitor:HDMI-A-1
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
