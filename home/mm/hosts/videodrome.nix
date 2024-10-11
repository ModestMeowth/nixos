{pkgs, ...}: {
  modules.neovim.profile = "development";
  programs.gh.enable = true;
  home.packages = [pkgs.commitizen];
}
