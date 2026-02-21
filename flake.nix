{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?shallow=1&ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?shallow=1&ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    ez-configs.url = "github:ehllie/ez-configs";
    ez-configs.inputs.nixpkgs.follows = "nixpkgs";
    ez-configs.inputs.flake-parts.follows = "flake-parts";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote.url = "github:nix-community/lanzaboote";

    sops-nix.url = "github:Mic92/sops-nix";

    home-manager.url = "github:nix-community/home-manager/release-25.11";

    wsl.url = "github:nix-community/nixos-wsl/release-25.11";

    nix-index-database.url = "github:nix-community/nix-index-database";

    # Ugghh, takes 2 styling flakes to do what I want
    catppuccin.url = "github:catppuccin/nix/release-25.11";

    stylix.url = "github:nix-community/stylix/release-25.11";

    # Walker
    elephant.url = "github:abenz1267/elephant";

    walker.url = "github:abenz1267/walker";
    walker.inputs.elephant.follows = "elephant";

    # Screensave
    terminaltexteffects.url = "github:chrisbuilds/terminaltexteffects?shallow=1";
  };

  nixConfig = {
    experimental-features = "nix-command flakes";
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
        ];

        systems = [
          "aarch64-linux"
          "x86_64-linux"
        ];

        ezConfigs = {
          root = ./.;
          globalArgs = { inherit inputs; };
          nixos.configurationEntryPoint = "configuration.nix";
          home.users = lib'.mkHomeConfigsForUser "mm";
        };

        perSystem =
          { pkgs, ... }:
          {
            devShells.default = import ./shell.nix { inherit pkgs; };
            packages.bootdev-cli = pkgs.callPackage ./packages/bootdev.nix { };
            formatter = pkgs.nixfmt;
          };
      }
    );
}
