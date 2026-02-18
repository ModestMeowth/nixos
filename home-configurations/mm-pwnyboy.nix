{ ezModules, pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home.username = "mm";
  home.homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";

  imports = with ezModules; [
    network-utils
  ];
}
