{inputs, ...}: let
  genPkgs = system: overlays: import inputs.nixpkgs {
      inherit system overlays;
  };
in {
  nixosSystem = system: hostname: let
    overlays = [];
    pkgs = genPkgs system overlays;
  in
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs pkgs system; };
      modules = [
        {
          _module.args.pkgs-unstable = import inputs.unstable {
            inherit system;
            config.allowUnfree = true;
          };
        }
        inputs.sops.nixosModules.sops
        inputs.nixDB.nixosModules.nix-index
        ../../system/hosts/${hostname}
      ];
    };

  homeConfig = system: hostname: username: let
    specialArgs = inputs // { inherit system hostname inputs; };
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
        ../../home/${hostname}/${username}
      ];
      extraSpecialArgs = specialArgs;
    };
}
