{ hostname, ... }: {
  imports = [
    ./home.nix
    ../hosts/${hostname}/home.nix
  ];

  home = {
    username = "mm";
    homeDirectory = "/home/mm";
    stateVersion = "25.11";
  };
}
