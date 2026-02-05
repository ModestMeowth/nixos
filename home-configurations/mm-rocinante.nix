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

  imports = [
    ezModules.bootdev
    ezModules.desktop
    ezModules.hyprland
    ezModules.syncthing
    ezModules.virt-manager
  ];
}
