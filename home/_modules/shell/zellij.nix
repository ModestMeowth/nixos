{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.shell.zellij;
  cfgBash = config.programs.bash;
  cfgFish = config.programs.fish;
  cfgZellij = config.programs.zellij;
  theme = pkgs.dracula.zellij.theme;
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
      "zellij/themes/dracula.kdl".text = theme;
    };

    programs.zellij.enableBashIntegration = (cfg.enable && cfgBash.enable);
    programs.bash = mkIf (cfg.enable && cfgBash.enable) {
      initExtra = mkOrder 100 # bash
        ''
          export ZELLIJ_AUTO_EXIT=true
          [[ "$TERM_PROGRAM" != "vscode" ]] && export ZELLIJ_AUTO_ATTACH=true
        '';
    };

    programs.zellij.enableFishIntegration = (cfg.enable && cfgFish.enable);
    programs.fish = mkIf (cfg.enable && cfgFish.enable) {
      interactiveShellInit = mkOrder 100 # fish
        ''
          set ZELLIJ_AUTO_EXIT true
          if not string match -qi "vscode" $TERM_PROGRAM
            set ZELLIJ_AUTO_ATTACH true
          end
        '';
    };
  };
}
