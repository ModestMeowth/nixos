{ lib, lib', pkgs, ... }:
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
      ".editorconfig".source = lib'.mkDotfile "editorconfig/editorconfig";
      ".local/bin/mosh".source = lib'.mkDotfile "bin/mosh";
      ".tmux.conf".source = lib'.mkDotfile "tmux/tmux.conf";
    };
  };

  programs = {
    man.generateCaches = lib.mkForce false;

    fish = {
      enable = true;
      interactiveShellInit = lib.mkAfter ''
        source $HOME/.config/fish/localconfig.fish
      '';
    };

    jjui.enable = true;
    jujutsu.enable = true;

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
      "bat".source = lib'.mkDotfile "bat";
      "git".source = lib'.mkDotfile "git";
      "jj".source = lib'.mkDotfile "jj";
      "fish/localconfig.fish".source = lib'.mkDotfile "fish/config.fish";
      "starship.toml".source = lib'.mkDotfile "starship/starship.toml";
    };
  };
}
