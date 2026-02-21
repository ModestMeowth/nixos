{
  ezModules,
  lib,
  pkgs,
  ...
}:
let
  mkBinFile' = source: {
    ".local/${source}" = {
      source = ../../dotfiles/${source};
      executable = true;
    };
  };
in
{
  imports = [
    ezModules.tte
    ezModules.walker

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprsunset.nix
    ./shell.nix
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.packages = with pkgs; [
    grim
    libxkbcommon # xkbcli

    unstable.hyprmon
    unstable.hyprpicker

    playerctl
    satty
    slurp
    wayfreeze
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    extraConfig = ''
      source = ~/.config/hypr/hyprland.conf.d/*
    '';
  };

  xdg.configFile."hypr/hyprland.conf.d" = {
    source = ../../dotfiles/hypr/hyprland.conf.d;
    recursive = true;
  };

  xdg.configFile."screensaver" = {
    source = ../../dotfiles/screensaver;
    recursive = true;
  };

  services.hyprpolkitagent.enable = true;

  home.file = lib.mkMerge [
    (mkBinFile' "bin/cmd-reboot")
    (mkBinFile' "bin/cmd-shutdown")
    (mkBinFile' "bin/cmd-logout")
    (mkBinFile' "bin/lock-screen")

    (mkBinFile' "bin/hyprland-submap-command")
    (mkBinFile' "bin/hyprland-window-close-all")
    (mkBinFile' "bin/hyprland-window-pop")
    (mkBinFile' "bin/hyprland-workspace-toggle-gaps")

    (mkBinFile' "bin/battery-remaining")
    (mkBinFile' "bin/brightness-display")
    (mkBinFile' "bin/brightness-keyboard")
    (mkBinFile' "bin/swayosd-brightness")
    (mkBinFile' "bin/audio-switch")

    (mkBinFile' "bin/launch-or-focus")
    (mkBinFile' "bin/launch-tui")
    (mkBinFile' "bin/launch-or-focus-tui")

    (mkBinFile' "bin/launch-audio")
    (mkBinFile' "bin/launch-bluetooth")
    (mkBinFile' "bin/launch-browser")
    (mkBinFile' "bin/launch-calculator")
    (mkBinFile' "bin/launch-editor")
    (mkBinFile' "bin/launch-file-manager")
    (mkBinFile' "bin/launch-password-manager")
    (mkBinFile' "bin/launch-screensaver")
    (mkBinFile' "bin/launch-sysmon")
    (mkBinFile' "bin/launch-walker")
    (mkBinFile' "bin/launch-wifi")

    (mkBinFile' "bin/launch-menu")
    (mkBinFile' "bin/keybind-menu")
    (mkBinFile' "bin/power-profiles-list")

    (mkBinFile' "bin/restart-app")
    (mkBinFile' "bin/restart-waybar")

    (mkBinFile' "bin/screenrecord")
    (mkBinFile' "bin/screenshot")
    (mkBinFile' "bin/screensaver")

    (mkBinFile' "bin/toggle-dnd")
    (mkBinFile' "bin/toggle-idle")
    (mkBinFile' "bin/toggle-nightlight")

    (mkBinFile' "bin/terminal-cwd")
    (mkBinFile' "bin/monitor-profile")
  ];
}
