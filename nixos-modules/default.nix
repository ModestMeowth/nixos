{
  ezModules,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = "25.11";

  imports =
    with inputs;
    [
      sops-nix.nixosModules.sops
      nix-index-database.nixosModules.nix-index
      stylix.nixosModules.stylix
      catppuccin.nixosModules.catppuccin
    ]
    ++ (with ezModules; [
      networkmanager
      secrets
      theme
      users
    ]);

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Chicago";

  nix = {
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
        "https://lanzaboote.cachix.org"
        "https://hyprland.cachix.org"
        "https://catppuccin.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      extra-trusted-public-keys = [
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };

  documentation = {
    doc.enable = lib.mkDefault false;
    info.enable = lib.mkDefault false;
    man.generateCaches = lib.mkForce false;
    nixos.enable = lib.mkForce false;
  };

  environment.systemPackages = with pkgs; [
    age
    curl
    diff-so-fancy
    eza
    fd
    fzf
    gh
    gum
    jq
    just
    killall
    lsof
    nixfmt
    psmisc
    ripgrep
    ripgrep-all
    sops
    treefmt
    taplo
    unzip
    usbutils
    wget
    yamlfmt
    yq
    zip
  ];

  networking.nftables.enable = true;

  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman
        batdiff
        prettybat
      ];
      settings.theme = ''"Catppuccin Macchiato"'';
    };

    command-not-found.enable = false;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    git.enable = true;

    htop.enable = true;

    mosh = {
      enable = true;
      openFirewall = true;
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 3";
      };
    };

    nix-index-database.comma.enable = true;

    starship.enable = true;
    tmux.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    zoxide.enable = true;
  };

  security = {
    pam.loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "5424288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];
  };

  services = {
    udisks2.enable = true;
    upower.enable = true;
  };

}
