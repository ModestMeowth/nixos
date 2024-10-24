{ config, lib, inputs, ... }: with lib; let
  cfg = config.modules.shell.fish.plugins.zellij;
in
{
  options.modules.shell.fish.plugins.zellij.enable = mkEnableOption "fish-zellij";

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableFishIntegration = true;
    };

    xdg.configFile = {
      "zellij/config.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/config.kdl";
      "zellij/layouts/default.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/layouts/default.kdl";
      "zellij/themes/dracula.kdl".source = "${inputs.dracula.outputs.zellij}";
    };
  };
}
