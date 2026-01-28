{ withSystem, inputs, ...}:
let
  mkHost =
    {hostname, mod ? [], system ? "x86_64-linux"}:
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
    {hostname, mod ? [], system ? "x86_64-linux"}:
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
in
{
  flake.nixosConfigurations = {
    "rocinante" = mkHost { hostname = "rocinante"; };
    "pwnyboy" = mkHost { hostname = "pwnyboy"; };

    "videodrome" = mkHost {
      hostname = "videodrome";
      mod = with inputs; [
        wsl.nixosModules.wsl
      ];
    };

    "skinman" = mkHost {
      hostname = "skinman";
      mod = with inputs; [
        nixos-hardware.nixosModules.raspberry-pi-4
      ];
    };

    rpi = inputs.nixpkgs.lib.nixosSystem {
      modules = [ ./nixosModules/rpi/mkimg.nix ];
    };
  };

  flake.homeConfigurations = {
    "mm@rocinante" = mkHome { hostname = "rocinante"; };
    "mm@pwnyboy" = mkHome { hostname = "pwnyboy"; };
    "mm@videodrome" = mkHome { hostname = "videodrome"; };
    "mm@skinman" = mkHome { hostname = "skinman"; system = "aarch64-linux"; };
  };
}
