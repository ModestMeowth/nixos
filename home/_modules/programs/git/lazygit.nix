{config, lib, ...}: {
  options.hm-mm.git.lazygit = lib.mkEnableOption "lazygit";

  config = lib.mkIf config.hm-mm.git.lazygit {
    programs.lazygit.enable = true;
  };
}
