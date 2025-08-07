{ inputs, mkPkgs }: {
  mkHost = {
      hostname
    , system ? "x86_64-linux"
    , additionalModules ? [ ]
    , additionalConfig ? [ ]
  }:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs {
        additionalConfig = additionalConfig;
        system = system; };
      specialArgs = { inherit inputs hostname; };
      modules = with inputs;
        [
          sops-nix.nixosModules.sops
          nixdb.nixosModules.nix-index
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs hostname; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.mm = import ../home { hostname = hostname; };
          }
          ../modules/shared
          ../modules/cli-tui
          ../hosts/${hostname}
        ] ++ additionalModules;
    };

  # Standalone home-manager
  mkHome = {
      hostname
    , system ? "x86_64-linux"
    , additionalConfig ? { }
    , additionalModules ? [ ]
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs {
        system = system;
        additionalConfig = additionalConfig;
      };

      extraSpecialArgs = { inherit inputs hostname; };
      modules = [
        inputs.sops-nix.homeManagerModules.sops
        ../home
      ] ++ additionalModules;
    };
}
