{config, lib, ...}: {
  options.hm-mm.git.gh = lib.mkEnableOption "gh";

  config = lib.mkIf config.hm-mm.git.gh {
    programs.gh.enable = true;
  };
}
