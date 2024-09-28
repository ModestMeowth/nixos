{pkgs, ...}: {
  fish-plugins = pkgs.callPackage ./fish-plugins/default.nix {};
  nvim-plugins = pkgs.callPackage ./nvim-plugins/default.nix {};
}
