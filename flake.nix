{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "nur";

    nixdb.url = "github:nix-community/nix-index-database";
    nixdb.inputs.nixpkgs.follows = "unstable";

    sops-nix.url = "sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.pre-commit-hooks-nix.follows = "";

    hm.url = "github:nix-community/home-manager/release-25.05";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    nix-virt.url = "github:AshleyYakeley/NixVirt";
    nix-virt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      mkHost = { hostname, system ? "x86_64-linux"
        , additionalConfig ? { } # nixpkgs.config options
        , additionalModules ? [ ] }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.nur.overlays.default
              (final: _: {
                unstable = import inputs.unstable {
                  inherit (final) system;
                  config = { allowUnfree = true; } // additionalConfig;
                };
              })
            ];
          };
        in inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs; };
          modules = with inputs;
            [
              sops-nix.nixosModules.sops
              nixdb.nixosModules.nix-index
              ./modules/shared
              ./modules/cli-tui
              ./hosts/${hostname}
            ] ++ additionalModules;
        };
    in {
      nixosConfigurations."rocinante" = mkHost {
        hostname = "rocinante";
        additionalConfig = { rocmSupport = true; };
        additionalModules = with inputs; [
          lanzaboote.nixosModules.lanzaboote
          ./modules/shared/physical
          ./modules/desktop
          ./modules/gaming
          hm.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mm = {
              imports = [
                ./modules/home-manager/hosts/rocinante
                ./modules/home-manager
              ];
            };
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      nixosConfigurations."pwnyboy" = mkHost {
        hostname = "pwnyboy";
        additionalModules = with inputs; [
          ./modules/zfs.nix
          lanzaboote.nixosModules.lanzaboote
          ./modules/console.nix
          ./modules/secureboot.nix
          nix-virt.nixosModules.default
          ./modules/libvirt.nix
        ];
      };

      nixosConfigurations."videodrome" = mkHost {
        hostname = "videodrome";
        additionalConfig = { cudaSupport = true; };
        additionalModules = with inputs; [ wsl.nixosModules.default ];
      };
    };
}
