{ ezModules, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home = {
    username = "mm";
    homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";
  };

  imports = with ezModules; [
    bootdev
    network-utils
  ];
}
