{ lib, ... }:
{
  catppuccin.fish.enable = false;
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.mkAfter ''
      source $HOME/.config/fish/localconfig.fish
    '';
  };

  xdg.configFile."fish/localconfig.fish".source = ../dotfiles/fish/config.fish;
}
