{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.wm.gnome.dracula;
in
{
  options.modules.wm.gnome.dracula.enable = mkEnableOption "gnome-dracula";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dracula-theme
      dracula-icon-theme
    ];

    gtk = {
      theme.name = "Dracula";
      iconTheme.name = "Dracula";
    };

    dconf.settings = {
      "org/gnome/shell/extensions/user-theme".name = "Dracula";
    };
  };
}
