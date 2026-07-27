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
        gtk = {
          colorScheme = polarity;

          font = {
            inherit (fonts.sansSerif) package name;
            size = fonts.sizes.applications;
          };
        };
      };
  };
}
