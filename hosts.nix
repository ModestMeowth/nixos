{ withSystem, inputs, ...}:
let
  mkHost =
    {hostname, mod ? [], system ? "x86_64-linux"}:
      withSystem system (ctx@{config, inputs', ...}:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            packages = config.packages;
            inherit inputs inputs';
          };

          modules = with inputs; [
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            ./nixosModules
            ./users
            ./hosts/${hostname}/configuration.nix
          ] ++ mod;
        });
  mkHome =
    {hostname, mod ? [], system ? "x86_64-linux"}:
      withSystem system (ctx@{config, inputs', pkgs, ...}:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            packages = config.packages;
            inherit inputs inputs';
          };

          modules = with inputs; [
            nixvim.homeModules.nixvim
            sops-nix.homeModules.sops
            stylix.homeModules.stylix
            ./homeModules
            ./hosts/${hostname}/home.nix
          ] ++ mod;
        });
in
{
  flake.nixosConfigurations = {
    "rocinante" = mkHost {
      hostname = "rocinante";
      mod = with inputs; [
        lanzaboote.nixosModules.lanzaboote
      ];
    };

    "pwnyboy" = mkHost {
      hostname = "pwnyboy";
      mod = with inputs; [
        lanzaboote.nixosModules.lanzaboote
      ];
    };

    "videodrome" = mkHost {
      hostname = "videodrome";
      mod = with inputs; [
        wsl.nixosModules.wsl
      ];
    };
  };

  flake.homeConfigurations = {
    "mm@rocinante" = mkHome { hostname = "rocinante"; };
    "mm@pwnyboy" = mkHome { hostname = "pwnyboy"; };
    "mm@videodrome" = mkHome { hostname = "videodrome"; };
  };
}
