{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curl
    dig
    virt-manager
    unstable.bootdev-cli
  ];
}
