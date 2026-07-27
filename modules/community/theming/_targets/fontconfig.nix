{ config, lib, ... }:
let
  cfg = config.theming;
in
{
  fonts.fontconfig.defaultFonts = lib.genAttrs [
    "monospace"
    "serif"
    "sansSerif"
    "emoji"
  ] (family: lib.mkOrder 600 [ cfg.fonts.${family}.name ]);
}
