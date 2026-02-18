{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    doggo
    nmap
  ];
}
