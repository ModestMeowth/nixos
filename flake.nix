{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";
    parts.url = "flake-parts";
    nur.url = "nur";
    sops.url = "sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "home-manager/release-24.11";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    virt.url = "github:AshleyYakeley/NixVirt/nixpkgs-24.05";
    virt.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { ... }@inputs:
    let
      genPkgs =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = builtins.attrValues (import ./overlays.nix { inherit inputs; });
        };
      xLib = import ./lib { inherit inputs genPkgs; };
    in
    inputs.parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = { system, inputs', self', pkgs, ... }: {
        _module.args.pkgs = genPkgs system;
        legacyPackages = import ./packages { inherit pkgs; };
      };

      flake.nixosConfigurations = {
        pwnyboy = xLib.nixosSystem "x86_64-linux" "pwnyboy";
        rocinante = xLib.nixosSystem "x86_64-linux" "rocinante";
        videodrome = xLib.nixosSystem "x86_64-linux" "videodrome";
      };
    };
}
