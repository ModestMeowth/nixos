{ config, ... }:
let
  mkSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
in {
  imports = [ ./browser.nix ./editor.nix ];

  home.username = "mm";
  home.homeDirectory = "/home/mm";
  home.stateVersion = "25.05";

  programs = { home-manager.enable = true; };

  home.file = {
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "git".source = mkSymlink "git";
    "fish/config.fish".source = mkSymlink "fish/config.fish";
    "nvim".source = mkSymlink "nvim";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
