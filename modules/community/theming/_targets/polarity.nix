{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.theming = {
    polarity = mkOption {
      type = types.nullOr (types.enum [
        "light"
        "dark"
      ]);

      default = null;
      description = ''
        Set color polarity, either light or dark
      '';
    };
  };
}
