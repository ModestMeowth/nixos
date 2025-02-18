{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";

    nixdb.url = "github:nix-community/nix-index-database";
    nixdb.inputs.nixpkgs.follows = "unstable";

    sops-nix.url = "sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.pre-commit-hooks-nix.follows = "";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    nix-virt.url = "github:AshleyYakeley/NixVirt";
    nix-virt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      mkHost =
        { hostname
        , system ? "x86_64-linux"
        , additionalModules ? [ ]
        }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (final: _: {
                unstable = import inputs.unstable {
                  inherit (final) system;
                  config.allowUnfree = true;
                };
              })
            ];
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = with inputs; [
            sops-nix.nixosModules.sops
            nixdb.nixosModules.nix-index
            ./modules
            ./hosts/${hostname}
          ] ++ additionalModules;
        };
    in
    {
      nixosConfigurations."rocinante" = mkHost {
        hostname = "rocinante";
        additionalModules = with inputs; [
          ./modules/zfs.nix
          lanzaboote.nixosModules.lanzaboote
          ./modules/secureboot.nix
        ];
      };

      nixosConfigurations."pwnyboy" = mkHost {
        hostname = "pwnyboy";
        additionalModules = with inputs; [
          ./modules/zfs.nix
          lanzaboote.nixosModules.lanzaboote
          ./modules/secureboot.nix
          nix-virt.nixosModules.default
          ./modules/libvirt.nix
        ];
      };

      nixosConfigurations."videodrome" = mkHost {
        hostname = "videodrome";
        additionalModules = with inputs; [
          wsl.nixosModules.default
        ];
      };
    };
}
