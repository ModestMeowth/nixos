{ config, pkgs, ... }:
let
  font = config.stylix.fonts.sansSerif.name;
in
{
  # the service definition does not play nice with bash
  # service.hypridle.enable = true;
  home.packages = [ pkgs.hypridle ];
  wayland.windowManager.hyprland.extraConfig = # lua
    ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("uwsm app -- hypridle")
      end)
    '';

  xdg.configFile = {
    "hypr/hypridle.conf".text = builtins.readFile ../../dotfiles/hypr/hypridle.conf;
    "screensaver" = {
      source = ../../dotfiles/screensaver;
      recursive = true;
    };
  };

  catppuccin.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;
    # hyprland lua colors now supported by catppucin, but breaks hyprlock because they removed all the .conf themes it referenced.
    # manually set colors until it is fixed
    extraConfig = ''
      $accent = rgb(cba6f7)
      $accentAlpha = cba6f7
      $surface0 = rgb(323244)
      $red = rgb(f38ba8)
      $text = rgb(cdd6f4)
      $textAlpha = cdd6f4
      $font = ${font}
    ''
    + builtins.readFile ../../dotfiles/hypr/hyprlock.conf;
  };
}
