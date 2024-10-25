{ config, lib, inputs, ... }: with lib; let
  cfg = config.modules.shell.zellij;
  cfgBash = config.programs.bash;
  cfgFish = config.programs.fish;
  cfgZellij = config.programs.zellij;
  theme = inputs.dracula.outputs.zellij;
in
{
  options.modules.shell.zellij.enable = mkEnableOption "shell-zellij";

  config = {
    xdg.configFile = mkIf cfgZellij.enable {
      "zellij/config.kdl".text = # kdl
        ''
          default_mode "normal"

          plugins {

            tab-bar {
              path "tab-bar"
            }

            status-bar {
              path "status-bar"
            }
            compact-bar {
              path "compact-bar"
            }
          }

          ui {
            pane_frames {
              rounded_corners true
            }
          }

          theme "dracula"
        '';

      "zellij/layouts/default.kdl".text = # kdl
        ''
          layout {
            pane
            pane size=1 borderless=true {
              plugin location="zellij:tab-bar"
            }
          }
        '';
      "zellij/themes/dracula.kdl".source = theme;
    };

    programs.zellij.enableBashIntegration = (cfg.enable && cfgBash.enable);
    programs.bash = mkIf (cfg.enable && cfgBash.enable) {
      initExtra = mkOrder 100 # bash
        ''
          if [ "$TERM_PROGRAM" == "vscode" ]; then
            export ZELLIJ_AUTO_ATTACH=true
            export ZELLIJ_AUTO_EXIT=true
          fi
        '';
    };

    programs.zellij.enableFishIntegration = (cfg.enable && cfgFish.enable);
    programs.fish = mkIf (cfg.enable && cfgFish.enable) {
      interactiveShellInit = mkOrder 100 # fish
        ''
          if not string match -qi "vscode" $TERM_PROGRM
            set ZELLIJ_AUTO_ATTACH true
            set ZELLIJ_AUTO_EXIT true
          end
        '';
    };
  };
}
