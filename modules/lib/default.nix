{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
  genPkgs = system: overlays:
    import inputs.nixpkgs {
      inherit system overlays;
    };
in {
  nixosSystem = system: hostname: let
    overlays = [];
    pkgs = genPkgs system overlays;
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs pkgs system;};
      modules = [
        {
          _module.args.pkgs-unstable = import inputs.unstable {
            inherit system;
            config.allowUnfree = true;
          };
        }
        inputs.sops.nixosModules.sops
        inputs.nixDB.nixosModules.nix-index
        inputs.secBoot.nixosModules.lanzaboote
        inputs.wsl.nixosModules.default
        ../../modules
        ../../hosts/${hostname}
      ];
    };

  homeConfig = system: hostname: username: let
    specialArgs = inputs // {inherit system hostname inputs;};
  in
    inputs.hm.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
      modules = [
        {
          _module.args.pkgs-unstable = import inputs.unstable {
            inherit system;
            config.allowUnfree = true;
          };
        }
        ../../users/${username}/hm
        ../../users/${username}/hm/hosts/${hostname}
      ];
      extraSpecialArgs = specialArgs;
    };
}
