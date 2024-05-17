{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flakeParts.url = "github:hercules-ci/flake-parts";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nixDB.url = "github:nix-community/nix-index-database";
    nixDB.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    dracula.url = "github:ModestMeowth/dracula";

    mm.url = "github:ModestMeowth/.github";
  };

  outputs = {flake-parts, ...} @ inputs: let
    xLib = import ./modules/lib {inherit inputs;};
  in
    inputs.flakeParts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64" "x86_64-linux"];

      flake.nixosConfigurations = {
        rocinante = xLib.nixosSystem "x86_64-linux" "rocinante";
        videodrome = xLib.nixosSystem "x86_64-linux" "videodrome";
      };

      flake.homeConfigurations = {
        "mm@rocinante" = xLib.homeConfig "x86_64-linux" "rocinante" "mm";
        "mm@videodrome" = xLib.homeConfig "x86_64-linux" "videodrome" "mm";
      };
    };
}
