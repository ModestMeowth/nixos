{ pkgs, ... }: { home.packages = with pkgs; [ virt-manager unstable.bootdev-cli ]; }
