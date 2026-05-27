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
  nixpkgs.config.cudaSupport = true;
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
    azahar.enable = true;
    bottles.enable = true;
    dolphin.enable = true;
    pcsx2.enable = true;
    retroarch.enable = true;
    rpcs3.enable = true;
    steam.enable = true;
  };

  home.packages = with pkgs; [
    gnome-calculator
    makemkv
    nautilus
    nautilus-open-any-terminal
    wireshark
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  wayland.windowManager.hyprland.settings = {
    config.opengl.nvidia_anti_flicker = true;
    monitor = [
      {
        output = "DP-1";
        mode = "3440x1440@60";
        position = "0x0";
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080";
        position = "3440x0";
        transform = 1;

      }
    ];

    workspace_rule = [
      {
        workspace = "1";
        monitor = "DP-1";
      }
      {
        workspace = "2";
        monitor = "HDMI-A-1";
      }
    ];
  };

  xdg.configFile = {
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
