{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
    };

    gh.enable  = true;

    jujutsu = {
      enable  = true;
      package = pkgs.unstable.jujutsu;
    };
  };

  xdg.configFile = {
    "git/config".source = ../dotfiles/git/config;
    "jj/config.toml".source = ../dotfiles/jj/config.toml;
  };
}
