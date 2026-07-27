{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.theming.fonts;
  mkFontOptions =
    {
      fontName,
      displayName,
      package,
    }:
    {
      package = lib.mkPackageOption pkgs package { } // {
        description = "Package providing the ${displayName} font.";
      };

      name = lib.mkOption {
        type = lib.types.str;
        description = "Name of the ${displayName} font.";
        default = fontName;
      };
    };
in
{
  options.theming.fonts = {
    serif = mkFontOptions {
      displayName = "Serif";
      fontName = "DejaVu Serif";
      package = "dejavu_fonts";
    };

    sansSerif = mkFontOptions {
      displayName = "Sans-serif";
      fontName = "DejaVu Sans";
      package = "dejavu_fonts";
    };

    monospace = mkFontOptions {
      displayName = "Monospace";
      fontName = "DejaVu Sans Mono";
      package = "dejavu_fonts";
    };

    emoji = mkFontOptions {
      displayName = "Emoji";
      fontName = "Noto Color Emoji";
      package = "noto-fonts-color-emoji";
    };

    sizes =
      let
        mkFontSizeOption =
          { default, target }:
          lib.mkOption {
            default = if builtins.isInt default then default else cfg.sizes.${default};
            defaultText =
              if builtins.isInt default then
                default
              else
                lib.literalExpression "config.theming.fonts.sizes.${default}";
            description = ''
              The font size used for ${target};
            '';

            type = with lib.types; either ints.unsigned float;
          };
      in
      {
        desktop = mkFontSizeOption {
          target = "window titles, status bars and other general elements";
          default = 10;
        };

        applications = mkFontSizeOption {
          target = "applications";
          default = 12;
        };

        terminal = mkFontSizeOption {
          target = "terminals and text editors";
          default = "applications";
        };

        popups = mkFontSizeOption {
          target = "notifications, popups and other overlay elements of the desktop";
          default = "desktop";
        };
      };

    packages = lib.mkOption {
      description = ''
        A list of all the font packages that will be installed.
      '';
      type = lib.types.listOf lib.types.package;
    };
  };

  config = {
    theming.fonts.packages = [
      cfg.monospace.package
      cfg.serif.package
      cfg.sansSerif.package
      cfg.emoji.package
    ];
  };
}
