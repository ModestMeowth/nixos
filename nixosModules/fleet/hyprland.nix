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
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    services.greetd = {
      enable = true;
      settings.default_session.command = ''
        ${pkgs.tuigreet}/bin/tuigreet --time --time-format "%R" --cmd "uwsm start -F -- hyprland-uwsm.desktop"
      '';
      useTextGreeter = true;
    };
  };
}
