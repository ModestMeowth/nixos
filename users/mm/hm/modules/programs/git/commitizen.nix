{config, lib, pkgs, ...}: {
  options.hm-mm.git.commitizen = lib.mkEnableOption "commitizen";

  config = lib.mkIf config.hm-mm.git.commitizen {
    home.packages = [ pkgs.commitizen ];
  };
}
