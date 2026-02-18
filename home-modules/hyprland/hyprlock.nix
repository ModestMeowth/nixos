{ config, ... }:
let
  font = config.stylix.fonts.sansSerif.name;
in
{
  catppuccin.hyprlock.useDefaultConfig = false;
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      $font = ${font}
    ''
    + builtins.readFile ../../dotfiles/hypr/hyprlock.conf;
  };
}
