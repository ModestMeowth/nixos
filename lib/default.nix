{ inputs, genPkgs }:
let
  lib = inputs.nixpkgs.lib.extend (final: prev: { myLib = import ./lib { lib = final; }; });
in
{
  nixosSystem =
    { hostname
    , system ? "x86_64-linux"
    , nixpkgs ? inputs.nixpkgs
    , myPkgs ? inputs.self.legacyPackages.${system}
    , baseModules ? with inputs; [
        sops.nixosModules.sops
        secBoot.nixosModules.lanzaboote
        wsl.nixosModules.default
        virt.nixosModules.default
        ../hosts/_modules
        ../hosts/${hostname}
      ]
    , extraModules ? [ ]
    ,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system lib;
      specialArgs = {
        inherit inputs myPkgs hostname;
      };
      pkgs = genPkgs system;
      modules = baseModules ++ extraModules;
    };

  homeConfig =
    { hostname
    , username
    , system ? "x86_64-linux"
    , nixpkgs ? inputs.nixpkgs
    , myPkgs ? inputs.self.legacyPackages.${system}
    ,
    }:
    inputs.hm.lib.homeManagerConfiguration {
      inherit lib;

      pkgs = genPkgs system;

      extraSpecialArgs = {
        inherit
          inputs
          myPkgs
          hostname
          username
          ;
      };

      modules = [
        inputs.sops.homeManagerModules.sops
        ../home/_modules
        ../home/${username}
      ];
    };
}
