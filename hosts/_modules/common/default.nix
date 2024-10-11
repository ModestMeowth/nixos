{
  imports = [
    ./locale.nix
    ./nix.nix
    ./shells.nix

    ./shares
  ];

  programs.direnv.enable = true;
  programs.git.enable = true;
}
