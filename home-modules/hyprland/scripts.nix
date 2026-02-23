{ lib, ... }:
let
  lib' = import ../lib.nix { inherit lib; };
in
{
  home.file = lib'.mkBinFiles ".local/bin" [
    "cmd-reboot"
    "cmd-shutdown"
    "cmd-logout"
    "lock-screen"

    "hyprland-submap-command"
    "hyprland-window-close-all"
    "hyprland-window-pop"
    "hyprland-workspace-toggle-gaps"

    "battery-remaining"
    "brightness-display"
    "brightness-keyboard"
    "swayosd-brightness"
    "audio-switch"

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

    "launch-menu"
    "keybind-menu"
    "power-profiles-list"

    "restart-app"
    "restart-waybar"

    "screenrecord"
    "screenshot"
    "screensaver"

    "toggle-dnd"
    "toggle-idle"
    "toggle-nightlight"

    "terminal-cwd"
  ];
}
