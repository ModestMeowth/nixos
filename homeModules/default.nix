{ config, lib, ... }:
let
  mkSymlink = p: config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${p}";
  HOME = config.home.homeDirectory;
in
{
  home.stateVersion = "25.11";
  news.display = "silent";

  imports = [
    ./neovim
  ];

  home = {
    username = "mm";
    homeDirectory = "/home/mm";

    file = {
      ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
      ".local/bin/mosh".source = mkSymlink "bin/mosh";
      ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
    };
  };

  programs = {
    fish.enable = true;
    fish.interactiveShellInit = lib.mkAfter ''
      source ${HOME}/.config/fish/localconfig.fish
    '';
  };

  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  xdg = {
    enable = true;
    configFile = {
      "bat".source = mkSymlink "bat";
      "git".source = mkSymlink "git";
      "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
      "starship.toml".source = mkSymlink "starship/starship.toml";
    };
  };
}
