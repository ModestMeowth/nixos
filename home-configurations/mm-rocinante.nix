{ ezModules, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
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
    }
  '';

  xdg.configFile."hypr/hyprland.conf.d/monitor.conf".text = ''
    monitorv2 {
      output = eDP-1
      mode = 1920x1200@60
    }
  '';
}
