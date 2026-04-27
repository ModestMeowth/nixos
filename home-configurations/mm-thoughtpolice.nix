{ config, ezModules, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
  wallpaper = config.stylix.image;
in
{
  home.username = "mm";
  home.homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";

  imports = with ezModules; [
    _3dprinting
    bootdev
    desktop
    gaming
    hyprland
    network-utils
    syncthing
    virt-manager
  ];

  gaming = {
    bottles = true;
    lutris = true;
  };

  home.packages = with pkgs; [
    gnome-calculator
    nautilus
    nautilus-open-any-terminal
    wireshark
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  wayland.windowManager.hyprland.settings.env = [
    "LIBVA_DRIVER_NAME,nvidia"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "ELECTRON_OZONE_PLATFORM_HINT,auto"
  ];

  xdg.configFile = {
    "uwsm/env".text = ''
      export LIBVA_DRIVER_NAME=nvidia
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export ELECTRON_OZONE_PLATFORM_HINT=auto
    '';

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
