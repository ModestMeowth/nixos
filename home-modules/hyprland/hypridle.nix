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

  catppuccin.hyprlock.useDefaultConfig = false;
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      $font = ${font}
    ''
    + builtins.readFile ../../dotfiles/hypr/hyprlock.conf;
  };
}
