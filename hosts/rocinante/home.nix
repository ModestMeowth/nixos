{ config, pkgs, ... }:
let
  mkSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
in {
  home.packages = with pkgs; [ bitwarden-desktop unstable.bootdev-cli virt-manager ];

  programs = {
    ghostty.enable = true;
    firefox.enable = true;
  };

  services.syncthing.enable = true;

  xsession.enable = true;

  xdg.configFile = {
    "background.jpeg".source = mkSymlink "wallpaper/nebula.jpeg";
    "ghostty".source = mkSymlink "ghostty";
    "hypr".source = mkSymlink "hypr";
    "mako".source = mkSymlink "mako";
    "walker".source = mkSymlink "walker";
    "waybar".source = mkSymlink "waybar";
  };
}
