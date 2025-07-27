{ inputs, pkgs, ... }: {
  system.stateVersion = "25.05";

  nix = {
    package = pkgs.nix;

    channel.enable = false;

    registry = {
      stable.flake = inputs.nixpkgs;
      unstable.flake = inputs.unstable;
    };

    settings = {
      nix-path = "nixpkgs=${inputs.nixpkgs.outPath}";
      experimental-features = [ "nix-command" "flakes" ];

      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = false;
      cores = 0;
      max-jobs = "auto";

      substituters =
        [ "https://nix-community.cachix.org" "https://devenv.cachix.org" ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
