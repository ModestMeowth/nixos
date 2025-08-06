{ config, lib, ... }:
let
  mkSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
in {
  imports = [ ./browser.nix ./editor.nix ];

  home = {
    username = "mm";
    homeDirectory = "/home/mm";
    stateVersion = "25.05";
  };

  programs = {
    home-manager.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = lib.mkAfter # fish
        ''
          source "$HOME/.config/fish/localconfig.fish"
        '';
    };
  };

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "doom".source = mkSymlink "doom";
    "bat".source = mkSymlink "bat";
    "btop/btop.conf".source = mkSymlink "btop/btop.conf";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "nvim".source = mkSymlink "nvim";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
