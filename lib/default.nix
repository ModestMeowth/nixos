{ inputs, mkPkgs }: {
  mkHost = { hostname, system ? "x86_64-linux", additionalConfig ? { }
    , additionalModules ? [ ] }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = mkPkgs {
        system = system;
        additionalConfig = additionalConfig;
      };
      specialArgs = { inherit inputs; };
      modules = with inputs;
        [
          sops-nix.nixosModules.sops
          ../modules/shared
          ../modules/cli-tui
          ../hosts/${hostname}
        ] ++ additionalModules;
    };

  mkHome = { hostname, system ? "x86_64-linux", additionalConfig ? { }
    , additionalModules ? [ ] }:
    inputs.hm.lib.homeManagerConfiguration {
      pkgs = mkPkgs {
        system = system;
        additionalConfig = additionalConfig;
      };
      extraSpecialArgs = { inherit inputs hostname; };
      modules = with inputs;
        [
          sops-nix.homeManagerModules.sops
          ../modules/home-manager
          ../modules/home-manager/hosts/${hostname}
        ] ++ additionalModules;
    };
}
