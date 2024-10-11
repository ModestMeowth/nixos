{config, lib, ...}: {
  options.hm-mm.shell.fish.zoxide = lib.mkEnableOption "fish-zoxide";

  config = lib.mkIf config.hm-mm.shell.fish.zoxide {
    programs.zoxide.enable = true;

    programs.fish.shellAbbrs = {
      cd = "z";
      ci = "zi";
    };
  };
}
