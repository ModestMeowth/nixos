{
  ezModules,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
  news.display = "silent";

  imports =
    with inputs;
    [
      sops-nix.homeModules.sops
      stylix.homeModules.stylix
      catppuccin.homeModules.catppuccin
    ]
    ++ (with ezModules; [

      editor
      fish
      theme
      unstable
      vcs
      yazi
    ]);

  nix = {
    package = pkgs.nix;
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "pwnyboy";
        sshUser = "mm";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      }
    ];

    settings = {
      experimental-features = "nix-command flakes";

      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      extra-substituters = [
        "https://catppuccin.cachix.org"
        "https://hyprland.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };

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
