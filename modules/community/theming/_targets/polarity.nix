{ lib, ... }:
{
  options.theming = {
    polarity = lib.mkOption {
      type = lib.types.enum [
        "prefer-dark"
        "light"
        "dark"
      ];

      default = "prefer-dark";
      description = ''
        Set color polarity, either light, dark or prefer-dark
      '';
    };
  };
}
