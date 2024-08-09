{config, lib, ...}: {
  options.hm-mm.shell.fish.eza = lib.mkEnableOption "fish-eza";

  config = lib.mkIf config.hm-mm.shell.fish.eza {
    programs = {
      eza.enable = true;

      fish.shellAbbrs = {
        "ls" = "eza --icons --sort=type";
        "ll" = "eza -l --icons --sort=type";
        "la" = "eza -lag --icons --sort=type";
      };
    };
  };
}
