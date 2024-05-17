{
  lib,
  ...
}: {
  dconf.settings = let
    inherit (lib.hm.gvariant) mkTuple;
  in {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "forge@jmmaranan.com"
        "gsconnect@andyholms.github.io"
      ];
    };

    "org/gnome/shell/extensions/user-theme".name = "Dracula";

    "org/gnome/desktop/background" = {
      primary-color = "#23c88";
      secondary-color = "#5789ca";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/symbolic-l.png";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/symbolic-d.png";
    };

    "org/gnome/desktop/screensaver" = {
      primary-color = "#23c88";
      secondary-color = "#5789ca";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/symbolic-l.png";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/symbolic-d.png";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple ["xkb" "us"])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "lv3:ralt_switch"
        "compose:ralt"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-enable-primary-paste = true;
      show-battery-percentage = true;
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      panel-run-dialog = ["<Super>space"];
      close = ["<Shift><Super>q"];
      toggle-fullscreen = [];
      minimize = ["<Super>h"];
      maximize = [];
      unmaximize = [];
      toggle-maximized = ["<Super>f"];
      begin-move = [];
      begin-resize = [];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-left = [];
      move-to-workspace-right = [];
      move-to-workspace-last = [];
      move-to-workspace-1 = [];
      switch-to-workspace-last = [];
      switch-to-workspace-1 = [];
      switch-to-workspace-left = [];
      switch-to-workspace-right = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      cycle-group = [];
      cycle-group-backward = [];
      switch-group = [];
      switch-group-backward = [];
    };

    "org/gnome/shell/keybindings" = {
      show-screen-recording-ui = ["<Super>Print"];
      focus-active-notificataion = [];
      toggle-quick-settings = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      help = [];
      screenreader = [];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      screensaver = ["<Control><Alt>Delete"];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "open-terminal";
      command = "wezterm start --cwd .";
      binding = "<Super><Shift>Return";
    };
  };
}
