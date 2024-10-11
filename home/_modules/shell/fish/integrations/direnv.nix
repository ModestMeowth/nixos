{config, lib, ...}: {
  options.hm-mm.shell.fish.direnv = lib.mkEnableOption "fish-direnv";

  config = lib.mkIf config.hm-mm.shell.fish.direnv {
    programs.direnv.enable = true;
  };
}
