{inputs, genPkgs}: let
  lib = inputs.nixpkgs.lib.extend (final: prev: { myLib = import ./lib { lib = final; }; });
in {
  nixosSystem = {
    hostname,
    system ? "x86_64-linux",
    nixpkgs ? inputs.nixpkgs,
    myPkgs ? inputs.self.legacyPackages.${system},
    baseModules ? [
      inputs.sops.nixosModules.sops
      inputs.nixDB.nixosModules.nix-index
      ../../modules
      ../../hosts/${hostname}
    ],
    extraModules ? [], }: inputs.nixpkgs.lib.nixosSystem {
      inherit system lib;
      specialArgs = {
        inherit inputs myPkgs hostname;
      };
      pkgs = genPkgs system;
      modules = baseModules ++ extraModules;
    };

  homeConfig = {
    hostname,
    username,
    system ? "x86_64-linux",
    nixpkgs ? inputs.nixpkgs,
    myPkgs ? inputs.self.legacyPackages.${system}
  }: inputs.hm.lib.homeManagerConfiguration {
    inherit lib;
    pkgs = genPkgs system;
    extraSpecialArgs = {
      inherit inputs myPkgs hostname;
    };
    modules = [
      inputs.sops.homeManagerModules.sops
      ../../users/${username}/hm
      ../../users/${username}/hm/hosts/${hostname}
    ];
  };
}
