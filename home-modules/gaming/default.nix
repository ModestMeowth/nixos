{ config, lib, ... }:
let
  cfg = config.gaming;
in
{
  imports = [
    ./bottles.nix
    ./lutris.nix
  ];

  options.gaming = {
    bottles = lib.mkEnableOption "bottles";
    lutris = lib.mkEnableOption "lutris";
  };

  config.nixpkgs.overlays = lib.mkIf (cfg.bottles || cfg.lutris) [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };
    })
  ];
}
