{ config, lib, ... }: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
  HOME = config.home.homeDirectory;
in {
  imports = [ ./neovim ];

  xdg.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.mkAfter # fish
      ''
        source ${HOME}/.config/fish/localconfig.fish
      '';
  };

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "bat".source = mkSymlink "bat";
    "btop/btop.conf".source = mkSymlink "btop/btop.conf";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
