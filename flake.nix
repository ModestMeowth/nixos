{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:Nixos/nixpkgs/nixos-unstable";

    parts.url = "github:hercules-ci/flake-parts";

    secBoot.url = "github:nix-community/lanzaboote";
    secBoot.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    sops.url = "github:Mic92/sops-nix";
    sops.inputs.nixpkgs.follows = "nixpkgs";

    nixDB.url = "github:nix-community/nix-index-database";
    nixDB.inputs.nixpkgs.follows = "nixpkgs";

    hm.url = "github:nix-community/home-manager";
    hm.inputs.nixpkgs.follows = "nixpkgs";

    dracula.url = "github:ModestMeowth/dracula";

    mm.url = "github:ModestMeowth/.github";
  };

  outputs = {...} @ inputs: let
    xLib = import ./modules/lib {inherit inputs;};
  in
    inputs.parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64" "x86_64-linux"];

      flake.nixosConfigurations = {
        rocinante = xLib.nixosSystem "x86_64-linux" "rocinante";
        videodrome = xLib.nixosSystem "x86_64-linux" "videodrome";
      };

      flake.homeConfigurations = {
        "mm@pwnyboy" = xLib.homeConfig "x86_64-linux" "pwnyboy" "mm";
        "mm@rocinante" = xLib.homeConfig "x86_64-linux" "rocinante" "mm";
        "mm@videodrome" = xLib.homeConfig "x86_64-linux" "videodrome" "mm";
      };
    };
}
