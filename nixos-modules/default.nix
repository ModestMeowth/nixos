{
  ezModules,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = "25.11";

  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    inputs.stylix.nixosModules.stylix
    inputs.catppuccin.nixosModules.catppuccin
    ezModules.nix-settings
    ezModules.secrets
    ezModules.theme
    ezModules.users
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/Chicago";

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
