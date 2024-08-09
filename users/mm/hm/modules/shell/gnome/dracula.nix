{config, lib, pkgs, ...}: {
  options.hm-mm.shell.gnome.dracula = lib.mkEnableOption "gnome-dracula";

  config = lib.mkIf config.hm-mm.shell.gnome.dracula {
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
