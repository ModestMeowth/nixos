{
  den.aspects.kmscon = {
    nixos =
      { config, ... }:
      let
        fonts = config.theming.fonts;
      in
      {
        services.kmscon = {
          enable = true;
          config = {
            hwaccel = true;
            font-name = fonts.monospace.name;
            font-size = fonts.sizes.terminal;
          };
        };
      };
  };
}
