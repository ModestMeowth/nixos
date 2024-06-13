{inputs, ...}: let
  genPkgs = system: overlays: import inputs.nixpkgs {
      inherit system overlays;
  };
in {
  nixosSystem = system: hostname: let
    overlays = [
      inputs.agenix.overlays.default
    ];
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
        inputs.agenix.nixosModules.default
        inputs.nixDB.nixosModules.nix-index
        ../../system/hosts/${hostname}
      ];
    };

  homeConfig = system: hostname: username: let
    overlays.agenix = inputs.agenix.overlays.default;
    specialArgs = inputs // { inherit system hostname overlays inputs; };
  in
    inputs.hm.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        overlays = builtins.attrValues overlays;
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
        inputs.agenix.homeManagerModules.age
        ../../home/${hostname}/${username}
      ];
      extraSpecialArgs = specialArgs;
    };
}
