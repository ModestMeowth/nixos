{ ezModules, inputs, lib, pkgs, ... }:
{
  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
  news.display = "silent";

  imports = [
    inputs.sops-nix.homeModules.sops
    inputs.nixvim.homeModules.nixvim

    ezModules.fish
    ezModules.neovim
    ezModules.unstable
    ezModules.vcs
  ];

  home = {
    file = {
      ".editorconfig".source = ../dotfiles/editorconfig/editorconfig;
      ".local/bin/mosh" = {
          source = ../dotfiles/bin/mosh;
          executable = true;
      };
      ".tmux.conf".source = ../dotfiles/tmux/tmux.conf;
    };
  };

  programs = {
    man.generateCaches = lib.mkForce false;

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

  xdg.enable = true;
}
