{
  den.aspects.desktop = {
    nixos = {
      programs.dconf.enable = true;
    };

    homeManager =
      { config, ... }:
      let
        HOME = config.home.homeDirectory;
      in
      {
        home.pointerCursor.enable = true;
        qt.enable = true;
        gtk.enable = true;

        xdg = {
          terminal-exec = {
            enable = true;
            settings.default = [ "com.mitchellh.ghostty.desktop" ];
          };

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
