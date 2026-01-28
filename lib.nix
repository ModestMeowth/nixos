{inputs, withSystem, ...}:
{
  mkHost =
    {hostname, mod ? [ ], system ? "x86_64-linux"}:
      withSystem system ({inputs', final, ...}:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = final;
          specialArgs = { inherit inputs inputs'; };
          modules = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            ./nixosModules
            ./users
            ./hosts/${hostname}/configuration.nix
          ] ++ mod;
      });
  mkHome =
    {hostname, mod ? [ ], system ? "x86_64-linux"}:
      withSystem system ({inputs', final, ...}:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = final;
          extraSpecialArgs = { inherit inputs inputs'; };

          modules = with inputs; [
            nixvim.homeModules.nixvim
            sops-nix.homeModules.sops
            stylix.homeModules.stylix
            ./homeModules
            ./hosts/${hostname}/home.nix
          ] ++ mod;
      });
}
