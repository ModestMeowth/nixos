{ lib, pkgs, ... }:
let
  lib' = import ../lib.nix { inherit lib; };
in
{
  home.packages = [ pkgs.lua5_5 ]; # keybind menu script needs lua, use same version hyprland does
  home.file = lib'.mkBinFiles ".local/bin" [
    "hyprland-window-close-all"
    "hyprland-window-pop"
    "hyprland-workspace-toggle-gaps"
    "hyprland-focused-monitor"

    "battery-remaining"

    "kbd-brightness"
    "kbd-brightness-mute"
    "screen-brightness"

    "osd-brightness"
    "osd-kbd-brightness"
    "osd-client"

    "audio-input-mute"
    "audio-output-switch"

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

    "capture-screencast"
    "capture-screenshot"

    "launch-menu"
    "keybind-menu"
    "power-profiles-list"

    "restart-app"
    "restart-waybar"

    "screensaver"

    "system-lock"
    "system-wake"

    "toggle-dnd"
    "toggle-idle"
    "toggle-nightlight"

    "terminal-cwd"
  ];
}
