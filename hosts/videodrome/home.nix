{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bootdev-cli
    curl
    dig
    virt-manager
  ];
}
