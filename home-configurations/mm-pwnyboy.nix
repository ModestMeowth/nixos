{ ezModules, pkgs, ... }:
{
  home = {
    username = "mm";
    homeDirectory = if isDarwin then "/Users/mm" else "/home/mm";
  };

  imports = with ezModules; [
    network-utils
  ];
}
