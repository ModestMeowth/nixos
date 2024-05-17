{pkgs, ...}: {
  programs = {
    eza.enable = true;

    fish.shellAbbrs = {
      "ls" = "eza --icons --sort=type";
      "ll" = "eza -l --icons --sort=type";
      "la" = "eza -lag --icons --sort=type";
    };
  };
}
