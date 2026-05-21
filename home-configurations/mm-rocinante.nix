{
  config,
  ezModules,
  pkgs,
  ...
}:
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
    flatpak
    gaming
    hyprland
    network-utils
    syncthing
    virt-manager
  ];

  gaming = {
    bottles.enable = true;
    retroarch.enable = true;
    steam.enable = true;
  };

  home.packages = with pkgs; [
    bitwarden-desktop
    gnome-calculator
    nautilus
    nautilus-open-any-terminal
    signal-desktop
    wireshark
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  wayland.windowManager.hyprland.settings = {
    config = {
      general.layout = "master";
      input.kb_options = "ctrl:swapcaps";
    };
    monitor = {
      output = "eDP-1";
      mode = "1920.x1200@60";
      vrr = 3;
    };
  };

  xdg.configFile = {
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
