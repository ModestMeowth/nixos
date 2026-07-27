{ lib, ... }:
{
  den.aspects.shell.provides = {
    fish = {
      nixos = {
        programs.fish.enable = true;
      };

      homeManager =
        { pkgs, ... }:
        {
          catppuccin.fish.enable = false;

          home.packages = with pkgs.fishPlugins; [
            fzf-fish
            puffer
          ];

          programs = {
            fzf.enable = true;
            fish = {
              enable = true;
              interactiveShellInit = lib.mkAfter ''
                source $HOME/.config/fish/localconfig.fish
              '';
            };
          };

          xdg.configFile."fish/localconfig.fish".source = ../../dotfiles/fish/config.fish;
        };
    };
  };
}
