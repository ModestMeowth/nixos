{ inputs, mkPkgs }: {
  mkHost = {
      hostname
    , system ? "x86_64-linux"
    , additionalConfig ? { }
    , additionalModules ? [ ]
    , additionalOverlays ? [ ]
  }:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs {
        additionalConfig = additionalConfig;
        additionalOverlays = additionalOverlays;
        system = system;
      };
      specialArgs = { inherit inputs hostname; };
      modules = with inputs;
        [
          { nixpkgs.hostPlatform = system; }
          sops-nix.nixosModules.sops
          nixdb.nixosModules.nix-index
          stylix.nixosModules.stylix
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
    , additionalOverlays ? [ ]
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs {
        system = system;
        additionalConfig = additionalConfig;
        additionalOverlays = additionalOverlays;
      };

      extraSpecialArgs = { inherit inputs hostname; };
      modules = with inputs; [
        sops-nix.homeManagerModules.sops
        nixvim.homeModules.nixvim
        stylix.homeModules.stylix
        ../home
      ] ++ additionalModules;
    };
}
