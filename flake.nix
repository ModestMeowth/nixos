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
