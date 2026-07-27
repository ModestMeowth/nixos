{
  theming.gtk = {
    nixos = {
      programs.dconf.enable = true;
    };

    homeManager =
      { config, ... }:
      let
        inherit (config.theming) fonts polarity;
      in
      {
        dconf.settings."org/gnome/desktop/interface".color-scheme = polarity;

        gtk.font = {
          inherit (fonts.sansSerif) package name;
          size = fonts.sizes.applications;
        };
      };
  };
}
