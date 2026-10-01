{
  den.aspects.desktop = {
    nixos =
      {config, lib, ...}:
      let
        gdm = config.services.displayManager.gdm;
      in
      {
        programs.dconf.enable = lib.mkDefault true;
        services.gnome.gnome-keyring.enable = lib.mkIf gdm.enable true;

        xdg.portal.xdgOpenUsePortal = true;
      };

    homeManager =
      { config, lib, osConfig, ... }:
      let
        HOME = config.home.homeDirectory;
        gdm = osConfig.services.displayManager.gdm;
      in
      {
        home.pointerCursor.enable = true;
        qt.enable = true;
        gtk.enable = true;

        services.gnome-keyring.enable = lib.mkIf gdm.enable true;

        xdg = {
          terminal-exec = {
            enable = true;
            settings.default = [ "com.mitchellh.ghostty.desktop" ];
          };

          portal.xdgOpenUsePortal = true;

          userDirs = {
            enable = true;
            createDirectories = true;

            desktop = null;
            templates = null;
            publicShare = null;

            setSessionVariables = true;

            extraConfig = {
              SCREENSHOT = "${HOME}/Pictures/Screenshots";
              SCREENRECORD = "${HOME}/Videos/Screencasts";
            };
          };
        };
      };
  };
}
