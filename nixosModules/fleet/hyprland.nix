{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.fleet.useHyprland;
in
{
  options.fleet.useHyprland = lib.mkEnableOption "use Hyprland";

  config = lib.mkIf cfg {
    environment.systemPackages = with pkgs; [
      brightnessctl
      hyprlock
      hypridle
      hyprpaper
      hyprpicker
      hyprsunset
      kitty
      libnotify
      mako
      walker
      waybar
      wl-clipboard
      (catppuccin-sddm.override {
        flavor = "macchiato";
        accent = "mauve";
        font = "Caskaydia Nerd Font";
        fontSize = "9";
      })
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.displayManager = {
      autoLogin = {
        enable = true;
        user = "mm";
      };

      sddm = {
        enable = true;
        wayland.enable = true;
        autoLogin.relogin = true;
        autoNumlock = true;
        theme = "catppuccin-macchiato-mauve";
      };
    };
  };
}
