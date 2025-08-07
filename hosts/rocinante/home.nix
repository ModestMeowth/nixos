{ config, pkgs, ... }:
let
  mkSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
in {
  home.packages = with pkgs; [ bitwarden-desktop unstable.bootdev-cli ];

  programs = {
    ghostty.enable = true;
    firefox.enable = true;
  };

  xdg.configFile = {
    "background.jpeg".source = "wallpaper/nebula.jpeg";
    "ghostty".source = mkSymlink "ghostty";
    "hypr".source = mkSymlink "hypr";
    "mako".source = mkSymlink "mako";
    "waybar".source = mkSymlink "waybar";
    "wofi".source = mkSymlink "wofi";
  };
}
