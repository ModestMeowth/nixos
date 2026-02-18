{ config, ... }:
let
  wallpaper = config.stylix.image;
in
{
  services.hyprpaper.enable = true;
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = , ${wallpaper}
  '';
}
