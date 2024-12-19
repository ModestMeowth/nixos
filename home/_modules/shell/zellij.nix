{ config, lib, pkgs, ... }:
let
  cfg = config.programs.zellij;
  cfgBash = config.programs.bash;
  cfgFish = config.programs.fish;
  theme = pkgs.dracula.zellij.theme;
in
{
  config = {
    xdg.configFile = lib.mkIf cfg.enable {
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
    programs.bash = lib.mkIf (cfg.enable && cfgBash.enable) {
      initExtra = lib.mkOrder 100 # bash
        ''
          export ZELLIJ_AUTO_EXIT=true
          [[ "$TERM_PROGRAM" != "vscode" ]] && export ZELLIJ_AUTO_ATTACH=true
        '';
    };

    programs.zellij.enableFishIntegration = (cfg.enable && cfgFish.enable);
    programs.fish = lib.mkIf (cfg.enable && cfgFish.enable) {
      interactiveShellInit = lib.mkOrder 100 # fish
        ''
          set ZELLIJ_AUTO_EXIT true
          if not string match -qi "vscode" $TERM_PROGRAM
            set ZELLIJ_AUTO_ATTACH true
          end
        '';
    };
  };
}
