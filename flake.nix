{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";

    ez-configs = {
      url = "github:ehllie/ez-configs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote.url = "github:nix-community/lanzaboote";

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager.url = "github:nix-community/home-manager";

    wsl.url = "github:nix-community/nixos-wsl";

    nix-index-database.url = "github:nix-community/nix-index-database";

    # Ugghh, takes 2 styling flakes to do what I want
    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:nix-community/stylix";

    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.7.0";
  };

  nixConfig = {
    experimental-features = "nix-command flakes";
    substituters = [
      "http://pwnyboy:8501?priority=1"
      "https://cache.nixos-cuda.org?=20"
      "https://nix-community.cachix.org?priority=30"
      "https://cache.nixos.org?priority=40"
    ];

    extra-substituters = [
      "https://lanzaboote.cachix.org?priority=10"
      "https://catppuccin.cachix.org?priority=11"
    ];

    trusted-public-keys = [
      "pwnyboy:GonEZtCkw+aFq6oHxKN7SB8y6p8NSkDuRsadSyZ0NuA="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    extra-trusted-public-keys = [
      "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
    ];
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      let
        lib' = import ./lib.nix { inherit config inputs; };
      in
      {
        imports = [
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.ez-configs.flakeModule
          ./flake-module.nix
        ];

        systems = import inputs.systems;

        ezConfigs = {
          root = ./.;
          globalArgs = { inherit inputs; };
          nixos.configurationEntryPoint = "configuration.nix";
          home.users = lib'.mkHomeConfigsForUser "mm";
        };
      }
    );
}
