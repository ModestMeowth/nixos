{ inputs, lib, pkgs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [(final: _: {
      unstable = import inputs.unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })];
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    keep-outputs = true;
    keep-derivations = true;
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };


  imports = [
    ./fleet
    ./gaming
    ./networkmanager.nix
    ./secrets.nix
    ./shares
  ];

  documentation = {
    nixos.enable = true;
    man.generateCaches = true;
  };

  environment.systemPackages = with pkgs; [
      age
      curl
      diff-so-fancy
      eza
      fd
      fzf
      gh
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

  fleet = {
    hasEfi = lib.mkDefault true;
    useZfs = lib.mkDefault true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking.nftables.enable = true;

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman batdiff prettybat
      ];
      settings.theme = "Catppuccin Machiato";
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

    nh.enable = true;
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

  time.timeZone = "America/Chicago";
}
