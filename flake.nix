{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:Nixos/nixpkgs/nixos-unstable";

    parts.url = "github:hercules-ci/flake-parts";

    hooks.url = "github:cachix/git-hooks.nix";
    hooks.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    treefmt.url = "github:numtide/treefmt-nix";
    treefmt.inputs.nixpkgs.follows = "nixpkgs";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    mm.url = "github:ModestMeowth/.github";
    dracula.url = "github:ModestMeowth/dracula";
  };

  outputs =
    { ... }@inputs:
    let
      genPkgs =
        system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues (import ./overlays { inherit inputs; });
          config.allowUnfree = true;
        };
      xLib = import ./lib { inherit inputs genPkgs; };
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [
        inputs.devshell.flakeModule
        inputs.hooks.flakeModule
        inputs.treefmt.flakeModule
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = genPkgs system;

          treefmt.config.projectRootFile = "flake.nix";
          treefmt.config.settings.global.excludes = [ "*.sops.*" ];
          treefmt.config.programs = {
            nixfmt.enable = true;
            taplo.enable = true;
            yamlfmt.enable = true;
          };

          pre-commit.settings.hooks = {
            treefmt.enable = true;
            pre-commit-hook-ensure-sops = {
              enable = true;
              files = "^\w+\.sops\.";
            };
          };

          legacyPackages = import ./packages { inherit pkgs; };
          devShells.default = pkgs.devshell.mkShell {
            imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
          };
        };

      flake.nixosConfigurations = {
        rocinante = xLib.nixosSystem { hostname = "rocinante"; };

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
