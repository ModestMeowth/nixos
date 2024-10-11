{inputs, config, lib, ...}: {
  options.hm-mm.term.foot = lib.mkEnableOption "foot";

  config = lib.mkIf config.hm-mm.term.foot {
    programs.foot.enable = true;
    xdg.configFile."foot/foot.ini".source = "${inputs.dotfiles}/dot_config/foot/foot.ini";
  };
}
