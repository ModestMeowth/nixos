{ config, lib, hostname, ... }:
let
  mkSymlink = p: config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${p}";
  HOME = config.home.homeDirectory;
in
{
  imports = [
    ./neovim
    ../hosts/${hostname}/home.nix
  ];

  home = {
    username = "mm";
    homeDirectory = "/home/mm";
    stateVersion = "25.11";
  };


  xdg.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.mkAfter # fish
      ''
        source ${HOME}/.config/fish/localconfig.fish
      '';
  };

  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin/mosh".source = mkSymlink "bin/mosh";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "bat".source = mkSymlink "bat";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
