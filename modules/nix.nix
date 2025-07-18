{ inputs, lib, pkgs, ...}: {
  nix = {
    package = pkgs.nix;

    channel.enable = false;

    registry = {
      stable.flake = inputs.nixpkgs;
      unstable.flake = inputs.unstable;
    };

    settings = {
      nix-path = "nixpkgs=${inputs.nixpkgs.outPath}";
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = false;
      cores = 0;
      max-jobs = "auto";

      substituters = [
        "https://devenv.cachix.org"
      ];

      trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
