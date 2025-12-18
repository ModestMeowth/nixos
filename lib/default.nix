{ inputs, mkPkgs }: {
  mkHost = {
      hostname
    , system ? "x86_64-linux"
    , additionalConfig ? { }
    , additionalModules ? [ ]
  }:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = mkPkgs {
        additionalConfig = additionalConfig;
        system = system; };
      specialArgs = { inherit inputs hostname; };
      modules = with inputs;
        [
          { nixpkgs.hostPlatform = system; }
          sops-nix.nixosModules.sops
          nixdb.nixosModules.nix-index
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
      modules = with inputs; [
        sops-nix.homeManagerModules.sops
        nixvim.homeModules.nixvim
        ../home
      ] ++ additionalModules;
    };
}
