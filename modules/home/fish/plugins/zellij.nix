{ inputs, ... }: {
  programs = {
    fish.shellInit = /*fish*/ ''
        if not string match -qi "vscode" $TERM_PROGRAM
          set ZELLIJ_AUTO_ATTACH true
          set ZELLIJ_AUTO_EXIT true
        end
      '';

    zellij = {
      enable = true;
      enableFishIntegration = false;
    };
  };

  xdg.configFile = {
    "zellij/config.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/config.kdl";
    "zellij/layouts/default.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/layouts/default.kdl";
    "zellij/themes/dracula.kdl".source = "${inputs.dracula.outputs.zellij}/dracula.kdl";
  };
}
