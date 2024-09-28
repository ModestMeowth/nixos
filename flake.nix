{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:Nixos/nixpkgs/nixos-unstable";

    parts.url = "github:hercules-ci/flake-parts";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    nixDB.url = "github:nix-community/nix-index-database";
    nixDB.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    dracula.url = "github:ModestMeowth/dracula";

    mm.url = "github:ModestMeowth/.github";
  };

  outputs = {...} @ inputs: let
    genPkgs = system:
      import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues (import ./overlays { inherit inputs; });
        config.allowUnfree = true;
      };
    xLib = import ./modules/lib {inherit inputs genPkgs;};
  in
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64" "x86_64-linux"];

      perSystem = { pkgs, system, ... }: {
        _module.args.pkgs = genPkgs system;
        formatter = pkgs.alejandra;
        legacyPackages = import ./packages { inherit pkgs; };
        devShells.default = pkgs.devshell.mkShell { imports = [
          (pkgs.devshell.importTOML ./devshell.toml)
        ];};
      };

      flake.nixosConfigurations = {
        rocinante = xLib.nixosSystem {
          hostname = "rocinante";
          extraModules = [
            inputs.secBoot.nixosModules.lanzaboote
            ./modules/hw/secureboot
          ];
        };

        videodrome = xLib.nixosSystem {
          hostname = "videodrome";
          extraModules = [
            inputs.wsl.nixosModules.default
            ./modules/hw/cpu/wsl
          ];
        };
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
