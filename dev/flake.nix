{
  inputs = {
    dev-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    dev-flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "dev-nixpkgs";
    };

    dev-systems.url = "github:nix-systems/default";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        gitignore.follows = "";
        nixpkgs.follows = "dev-nixpkgs";
      };
    };

    flake-compat.url = "github:nixos/flake-compat";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "dev-nixpkgs";
    };
  };

  outputs = _: { };
}
