{pkgs, ...}:
{
  nixpkgs.overlays = [
    (final: _: {
      bootdev-cli = final.callPackage ../packages/bootdev.nix { };
    })
  ];

  home.packages = [pkgs.bootdev-cli];
}
