{inputs, lib, ...}: {
  nix = {
    registry = {
      stable.flake = inputs.nixpkgs;
      unstable.flake = inputs.unstable;
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      log-lines = lib.mkDefault 25;
    };
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 5";
    };
  };
}
