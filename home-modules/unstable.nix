{inputs, pkgs, ...}:
{
  nixpkgs.overlays = [
    (_: _: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (pkgs.stdenv.hostPlatform) system;
      };
    })
  ];
}
