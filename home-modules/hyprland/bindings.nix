{lib, ...}:
let
  lua = lib.generators.mkLuaInline;
  mainMod = "SUPER";

  bind =
    keys: cmd: opts:
      {
        _args = [
          keys
          (lua cmd)
          opts
        ];
      };

  exec =
    bin: #lua
      ''hl.dsp.exec_cmd("${bin}")'';
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      (bind "${mainMod}+RETURN" (exec "xdg-terminal-exec") {
        description = "Open Terminal";
      })

      (bind "${mainMod}+E" (exec "launch-file-manager") {
        description = "Open File Manager";
      })

      (bind "${mainMod}+D" (exec ''launch-browser --profile=\"Default\"'') {
        description = "Open Browser";
      })

      (bind "${mainMod}+J" (exec ''launch-browser --profile=\"Work\"'') {
        description = "Open Browser (Work profile)";
      })

      (bind "${mainMod}+W" #lua
        ''hl.dsp.window.close()''
        {
          description = "Close Window";
        }
      )

      (bind "${mainMod}+SHIFT+Q" (exec "hyprshutdown") {
        description = "Exit Hyprland";
      })

      # Window Navigation
      (bind "${mainMod}+H" #lua
        ''hl.dsp.focus({direction = "l"})'' {
          description = "Move window focus to the left";
        })
      (bind "${mainMod}+SHIFT+H" #lua
        ''hl.dsp.window.swap({direction = "l"})'' {
          description = "Swap window to the left";
        })

      (bind "${mainMod}+J" #lua
        ''hl.dsp.focus({direction = "d"})'' {
          description = "Move window focus downward";
        })
      (bind "${mainMod}+SHIFT+J" #lua
        ''hl.dsp.window.swap({direction = "d"})'' {
          description = "Swap window downward";
        })

      (bind "${mainMod}+K" #lua
        ''hl.dsp.focus({direction = "u"})'' {
          description = "Move window focus upward";
        })
      (bind "${mainMod}+SHIFT+K" #lua
        ''hl.dsp.window.swap({direction = "u"})'' {
          description = "Swap window upward";
        })

      (bind "${mainMod}+L" #lua
        ''hl.dsp.focus({direction = "r"})'' {
          description = "Move window focus to the right";
        })
      (bind "${mainMod}+SHIFT+L" #lua
        ''hl.dsp.window.swap({direction = "r"})'' {
          description = "Swap window to the right";
        })
    ];
  };
}
