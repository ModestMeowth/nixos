{pkgs, ... }:
{
  tailscale = pkgs.callPackage ./tailscale.nix { };
  bootdev-cli = pkgs.callPackage ./bootdev.nix { };
}
