{
  programs = {
    git = {
      enable = true;
    };

    gh.enable = true;

    jujutsu = {
      enable = true;
    };
  };

  xdg.configFile = {
    "git/config".source = ../dotfiles/git/config;
    "jj/config.toml".source = ../dotfiles/jj/config.toml;
  };
}
