{inputs, self, withSystem, ...}:
let
  lib' = import ./. { inherit self; };
in
{
  mkHome = {hostname, mod ? [ ], system ? "x86_64-linux"}:
    withSystem system ({inputs', final, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = final;
        extraSpecialArgs = { inherit inputs inputs' lib'; };

        modules = with inputs; [
          nixvim.homeModules.nixvim
          sops-nix.homeModules.sops
          stylix.homeModules.stylix
          "${self}/homeModules"
          "${self}/hosts/${hostname}/home.nix"
        ] ++ mod;
      });

  mkHost = {hostname, mod ? [ ], system ? "x86_64-linux"}:
    withSystem system ({inputs', final, ...}:
      inputs.nixpkgs.lib.nixosSystem {
        pkgs = final;
        specialArgs = { inherit inputs inputs' lib'; };
        modules = with inputs; [
          lanzaboote.nixosModules.lanzaboote
          nix-index-database.nixosModules.nix-index
          sops-nix.nixosModules.sops
          "${self}/nixosModules"
          "${self}/users"
          "${self}/hosts/${hostname}/configuration.nix"
        ] ++ mod;
      });
  }
