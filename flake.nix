{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?shallow=1&ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?shallow=1&ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    ez-configs.url = "github:ehllie/ez-configs";
    ez-configs.inputs.nixpkgs.follows = "nixpkgs";
    ez-configs.inputs.flake-parts.follows = "flake-parts";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/nixos-wsl/release-25.11";
    wsl.inputs.nixpkgs.follows = "nixpkgs";
    wsl.inputs.flake-compat.follows = "";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-25.11";

    elephant.url = "github:abenz1267/elephant";
    elephant.inputs.nixpkgs.follows ="nixpkgs";
    walker.url = "github:abenz1267/walker";
    walker.inputs.elephant.follows = "elephant";
    walker.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; }
    ({config, ...}:
    {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.ez-configs.flakeModule
      ];

      systems = ["aarch64-linux" "x86_64-linux"];

      ezConfigs = {
        root = ./.;
        globalArgs = { inherit inputs; };
        nixos.configurationEntryPoint = "configuration.nix";
        home.users =
          let
            inherit (builtins) attrNames;
            inherit (inputs.nixpkgs.lib) forEach mergeAttrsList;
            allHosts = (config.flake.nixosConfigurations
              // config.flake.darwinConfigurations);
            allMM = mergeAttrsList (
              forEach (attrNames allHosts)
              (host: {
                  "mm-${host}".nameFunction = (_: "mm@${host}");
              }));
          in
            allMM;

      };

      perSystem =
        {pkgs, ...}:
        {
          devShells.default = import ./shell.nix { inherit pkgs; };
          packages.bootdev-cli = pkgs.callPackage ./packages/bootdev.nix { };
          formatter = pkgs.nixfmt;
        };
    });
}
