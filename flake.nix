{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "nur";

    nixdb.url = "github:nix-community/nix-index-database";

    sops-nix.url = "sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.pre-commit-hooks-nix.follows = "";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkPkgs = {
          system ? "x86_64-linux"
        , additionalConfig ? [ ]
      }:
        import inputs.nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays = with inputs;
            [
              nur.overlays.default
              (final: _: {
                unstable = import inputs.unstable {
                  inherit (final) system;
                  config = { allowUnfree = true; };
                };
              })
            ];
        };

      customLib = import ./lib { inherit inputs mkPkgs; };
    in with customLib; {
      nixosConfigurations = {
        "rocinante" = mkHost {
          hostname = "rocinante";
          additionalConfig = { rocmSupport = true; };
          additionalModules = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            ./modules/shared/physical
            ./modules/desktop
            ./modules/gaming
          ];
        };

        "pwnyboy" = mkHost {
          hostname = "pwnyboy";
          additionalModules = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            ./modules/shared/physical
          ];
        };

        "videodrome" = mkHost {
          hostname = "videodrome";
          additionalConfig = { cudaSupport = true; };
          additionalModules = with inputs; [
            wsl.nixosModules.default
            ./modules/shared/virtual/wsl.nix
          ];
        };
      };

      homeConfigurations = { };
    };
}
