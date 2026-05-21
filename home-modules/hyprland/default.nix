{ ezModules, ... }:
{
  imports = [
    ezModules.walker

    ./animations.nix
    ./bindings.nix
    ./hypridle.nix
    ./scripts.nix
    ./shell.nix
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  catppuccin.hyprland.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    settings = {
      config = {
        cursor = {
          no_hardware_cursors = true;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 2;
            passes = 1;
          };
        };

        dwindle = {
          force_split = 2;
          preserve_split = true;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          resize_on_border = false;
          allow_tearing = false;
        };

        input = {
          kb_layout = "us";
          repeat_rate = 40;
          repeat_delay = 600;

          numlock_by_default = true;

          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
            scroll_factor = 0.4;
            disable_while_typing = true;
            drag_3fg = 1;
          };
        };

        master = {
          mfact = 0.60;
          allow_small_split = true;
          orientation = "right";
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          focus_on_activate = false;
          disable_watchdog_warning = true;

          key_press_enables_dpms = true;
          mouse_move_enables_dpms = true;
        };
      };
    };

    extraConfig = #lua
    ''
      for workspace = 1, 6 do
        key = "code:" .. tostring(workspace+9)
        hl.bind(
          "SUPER+" .. key,
          hl.dsp.focus({ workspace = tostring(workspace) }),
          { description = "Switch to workspace " .. workspace })
        hl.bind(
          "SUPER+SHIFT+" .. key,
          hl.dsp.window.move({ workspace = tostring(workspace) }),
          { description = "Move window to workspace " .. workspace })
        hl.bind(
          "SUPER+SHIFT+ALT+" .. key,
          hl.dsp.window.move({workspace = tostring(workspace), follow = false}),
          { description = "Move window silently to workspace " .. workspace })
      end
    '';
  };
}
