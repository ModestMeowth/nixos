{ config, pkgs, ... }:
let
  mkSymlink = path:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
in {
  home.packages = with pkgs; [
    bitwarden-desktop
    unstable.bootdev-cli
    unstable.google-chrome
    virt-manager ];

  programs = {
    ghostty.enable = true;
    # firefox.enable = true;
    #chromium.enable = true;
  };

  services.syncthing.enable = true;

  xsession.enable = true;

  xdg.configFile = {
    "nebula.jpeg".source = mkSymlink "wallpaper/nebula.jpeg";
    "Cat.png".source = mkSymlink "wallpaper/Cat.png";
    "dark-cat-rosewater.png".source = mkSymlink "wallpaper/dark-cat-rosewater.png";
    "face.png".source = mkSymlink "wallpaper/face.png";
    "ghostty".source = mkSymlink "ghostty";
    "hypr".source = mkSymlink "hypr";
    "mako".source = mkSymlink "mako";
    "walker".source = mkSymlink "walker";
    "waybar".source = mkSymlink "waybar";
  };
}
