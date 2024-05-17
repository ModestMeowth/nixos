{inputs, ...}: {
  programs.foot.enable = true;
  xdg.configFile."foot/foot.ini".source = "${inputs.dotfiles}/dot_config/foot/foot.ini";
}
