{ config, pkgs, ... }:
let
  font = config.stylix.fonts.sansSerif.name;
in
{
  services.hypridle.enable = true;
  xdg.configFile = {
    "hypr/hypridle.conf".text = builtins.readFile ../../dotfiles/hypr/hypridle.conf;
    "screensaver" = {
      source = ../../dotfiles/screensaver;
      recursive = true;
    };
  };

  catppuccin.hyprlock.useDefaultConfig = false;
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      $font = ${font}
    ''
    + builtins.readFile ../../dotfiles/hypr/hyprlock.conf;
  };
}
