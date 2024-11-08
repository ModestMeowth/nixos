{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:Nixos/nixpkgs/nixos-unstable";

    parts.url = "github:hercules-ci/flake-parts";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager/release-24.05";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    virt.url = "github:AshleyYakeley/NixVirt/nixpkgs-24.05";
    virt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs:
    let
      genPkgs =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (final: _: {
              unstable = import inputs.unstable {
                inherit (final) system;
                config.allowUnfree = true;
                overlays = [];
              };
            })
          ];
        };
      xLib = import ./lib { inherit inputs genPkgs; };
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = {system, inputs', self', pkgs, ...}: {
          _module.args.pkgs = genPkgs system;
          legacyPackages = import ./packages { inherit pkgs; };
        };

      flake.nixosConfigurations = {
        rocinante = xLib.nixosSystem {
          hostname = "rocinante";
        };
        videodrome = xLib.nixosSystem { hostname = "videodrome"; };
      };

      flake.homeConfigurations = {
        "mm@rocinante" = xLib.homeConfig {
          username = "mm";
          hostname = "rocinante";
        };

        "mm@videodrome" = xLib.homeConfig {
          username = "mm";
          hostname = "videodrome";
        };

        "mm@pwnyboy" = xLib.homeConfig {
          username = "mm";
          hostname = "pwnyboy";
        };
      };
    };
}
