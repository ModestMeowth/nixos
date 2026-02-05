{ezModules, ...}:
{
  nixpkgs.system = "aarch64-linux"; # system is getting clobbered somewhere, this works for now
  home = {
    username = "mm";
    homeDirectory = "/home/mm";
  };

  imports = [
    ezModules.network-utils
    ezModules.syncthing
  ];
}
