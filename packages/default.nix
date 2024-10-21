{ pkgs, ... }:
{
  keys = pkgs.callPackage ./keys/default.nix { };
  fish-plugins = pkgs.fishPlugins.callPackage ./fish-plugins/default.nix { };
  neovim-plugins = pkgs.callPackage ./neovim-plugins/default.nix { };
}
