{ config, lib, pkgs, ... }:
let
  HOME = config.home.homeDirectory;
  mkSymlink = p: config.lib.file.mkOutOfStoreSymlink "${HOME}/code/nixos/dotfiles/${p}";
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
    fish = {
      enable = true;
      interactiveShellInit = lib.mkAfter ''
        source ${HOME}/.config/fish/localconfig.fish
      '';
    };

    jjui.enable = true;
    jujutsu = {
      enable = true;
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      plugins = with pkgs.yaziPlugins; {
        git = git;
        mediainfo = mediainfo;
        mount = mount;
        ouch = ouch;
        rich-preview = rich-preview;
        starship = starship;
        time-travel = time-travel;
        yatline = yatline;
        yatline-catppuccin = yatline-catppuccin;
      };

      initLua = ''
        local catppuccin_theme = require("yatline-catppuccin"):setup("macchiato")
        require("yatline"):setup({
          theme = catppuccin_theme,
        })
      '';
    };
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
