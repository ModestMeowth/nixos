{
  theming.default = {
    nixos =
      { config, ... }:
      let
        cfg = config.theming;
      in
      {
        imports = [ ./_targets/fonts.nix ];

        fonts = { inherit (cfg.fonts) packages; };
      };

    homeManager =
      { config, ... }:
      let
        cfg = config.theming;
      in
      {
        imports = [ ./_targets/fonts.nix ];

        home = { inherit (cfg.fonts) packages; };
      };
  };
}
