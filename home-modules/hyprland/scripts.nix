{ lib, pkgs, ... }:
let
  lib' = import ../lib.nix { inherit lib; };
in
{
  home.packages = [ pkgs.lua5_5 ]; # keybind menu script needs lua, use same version hyprland does
  home.file = lib'.mkBinFiles ".local/bin" [
    "lock-screen"

    # "hyprland-submap-command"
    # "hyprland-window-close-all"
    # "hyprland-window-pop"
    # "hyprland-workspace-toggle-gaps"
    "hyprland-focused-monitor"

    "battery-remaining"
    "brightness-display"
    "brightness-keyboard"
    "swayosd-brightness"
    "audio-switch"

    "hyprscope"

    "launch-or-focus"
    "launch-tui"
    "launch-or-focus-tui"

    "launch-audio"
    "launch-bluetooth"
    "launch-browser"
    "launch-calculator"
    "launch-editor"
    "launch-file-manager"
    "launch-password-manager"
    "launch-screensaver"
    "launch-sysmon"
    "launch-walker"
    "launch-wifi"

    # "capture-screencast"
    # "capture-screenshot"

    # "launch-menu"
    "keybind-menu"
    # "power-profiles-list"

    "restart-app"
    "restart-waybar"

    "screensaver"

    "toggle-dnd"
    "toggle-idle"
    "toggle-nightlight"

    "terminal-cwd"
  ];
}
