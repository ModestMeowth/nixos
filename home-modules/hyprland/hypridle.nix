{ config, pkgs, ... }:
let
  font = config.stylix.fonts.sansSerif.name;
in
{
  home.packages = [ pkgs.unstable.hypridle ];

  xdg.configFile = {
    "hypr/hypridle.conf".text = builtins.readFile ../../dotfiles/hypr/hypridle.conf;
    "screensaver" = {
      source = ../../dotfiles/screensaver;
      recursive = true;
    };
  };

  catppuccin.hyprlock.useDefaultConfig = false;
  programs.hyprlock = {
    package = pkgs.unstable.hyprlock;
    enable = true;
    extraConfig = ''
      $font = ${font}
    ''
    + builtins.readFile ../../dotfiles/hypr/hyprlock.conf;
  };

  # hypridle systemd service does not have bash for some reason I can't seem to fix
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = uwsm-app -- hypridle
  '';
}
