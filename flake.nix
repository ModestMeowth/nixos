{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/nixos-wsl/release-25.11";
    wsl.inputs.nixpkgs.follows = "nixpkgs";
    wsl.inputs.flake-compat.follows = "";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-25.11";
  };

  outputs =
    inputs@{flake-parts, nixpkgs, self, ...}:
    flake-parts.lib.mkFlake { inherit inputs; }
    {
      imports = [
        flake-parts.flakeModules.easyOverlay
        ./hosts.nix
      ];

      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {config, inputs', pkgs, system, ...}:
        {
          packages = import ./packages { inherit inputs' pkgs; };
          overlayAttrs = config.packages;
          _module.args.pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ self.overlays.default ];
          };

          devShells.default = import ./shell.nix { inherit inputs' pkgs; };
        };
    };
}
