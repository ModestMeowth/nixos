{ inputs, genPkgs }: {
  nixosSystem = system: hostname:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = genPkgs system;
      modules = with inputs; [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs system;
          };
        }
        secBoot.nixosModules.lanzaboote
        sops.nixosModules.sops
        wsl.nixosModules.default
        virt.nixosModules.default
        ../hosts/_modules
        ../hosts/${hostname}

        hm.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            sharedModules = with inputs; [
              sops.homeManagerModules.sops
              virt.homeModules.default
            ];
            extraSpecialArgs = {
              inherit inputs hostname system;
            };
            users.mm = ../. + "/home/mm";
          };
        }
      ];
    };
}
