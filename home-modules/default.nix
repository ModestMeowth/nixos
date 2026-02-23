{
  ezModules,
  inputs,
  lib,
  ...
}:
{
  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
  news.display = "silent";

  imports = [
    inputs.sops-nix.homeModules.sops
    inputs.stylix.homeModules.stylix
    inputs.catppuccin.homeModules.catppuccin

    ezModules.nix-settings
    ezModules.editor
    ezModules.fish
    ezModules.theme
    ezModules.unstable
    ezModules.vcs
    ezModules.yazi
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

    eza = {
      enable = true;

      colors = "auto";
      git = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
  };

  services.ssh-agent = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  stylix.targets = {

  };

  xdg.enable = true;
}
