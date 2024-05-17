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
      };
      modules = [
        inputs.agenix.homeManagerModules.age
        ../../home/${hostname}/${username}
      ];
      extraSpecialArgs = specialArgs;
    };
}
