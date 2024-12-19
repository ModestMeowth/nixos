{ pkgs, ... }:
{
  dracula = pkgs.callPackage ./dracula.nix {};
  fish-plugins = pkgs.fishPlugins.callPackage ./fish-plugins.nix {};
  keys = pkgs.callPackage ./keys.nix {};
  neovim-plugins = pkgs.callPackage ./neovim-plugins.nix {};
  zfs-rebalance = pkgs.callPackage ./zfs-rebalance.nix {};
}
