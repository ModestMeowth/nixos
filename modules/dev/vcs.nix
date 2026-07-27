{ inputs, ... }:
{
  den.aspects.dev = {
    nixos = {
      programs.git = {
        enable = true;
        lfs.enable = true;
      };
    };

    homeManager = {
      programs = {
        git = {
          enable = true;
          lfs.enable = true;
        };
        gh.enable = true;
        jujutsu.enable = true;
      };

      xdg.configFile = {
        "git/config".source = inputs.self + /dotfiles/git/config;
        "jj/config.toml".source = inputs.self + /dotfiles/jj/config.toml;
      };
    };
  };
}
