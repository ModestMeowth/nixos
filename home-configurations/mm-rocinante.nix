{ezModules, pkgs, ...}:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  home = {
    username = "mm";
    homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";

    packages = with pkgs; [
      bitwarden-desktop
      google-chrome
      signal-desktop
      wireshark
    ];
  };

  imports = with ezModules; [
    bootdev
    desktop
    hyprland
    network-utils
    syncthing
    virt-manager
  ];
}
