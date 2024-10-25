{ config, lib, inputs, ... }: with lib; let
  cfg = config.modules.shell.zellij;
  cfgBash = config.programs.bash;
  cfgFish = config.programs.fish;
  cfgZellij = config.programs.zellij;
in
{
  options.modules.shell.zellij.enable = mkEnableOption "shell-zellij";

  config = {
    xdg.configFile = mkIf cfgZellij.enable {
      "zellij/config.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/config.kdl";
      "zellij/layouts/default.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/layouts/default.kdl";
      "zellij/themes/dracula.kdl".source = inputs.dracula.outputs.zellij;
    };

    programs.zellij.enableBashIntegration = (cfg.enable && cfgBash.enable);
    programs.bash = mkIf (cfg.enable && cfgBash.enable) {
      initExtra = mkBefore # bash
        ''
          if [ "$TERM_PROGRAM" == "vscode" ]; then
            export ZELLIJ_AUTO_ATTACH=true
            export ZELLIJ_AUTO_EXIT=true
          fi
        '';
    };

    programs.zellij.enableFishIntegration = (cfg.enable && cfgFish.enable);
    programs.fish = mkIf (cfg.enable && cfgFish.enable) {
      interactiveShellInit = mkBefore # fish
        ''
          if not string match -qi "vscode" $TERM_PROGRM
            set ZELLIJ_AUTO_ATTACH true
            set ZELLIJ_AUTO_EXIT true
          end
        '';
    };
  };
}
