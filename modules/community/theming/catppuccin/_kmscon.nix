{ config, lib, ... }:
let
  inherit (config.catppuccin) flavor sources;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;

  color =
    name:
    let
      c = palette."${name}".rgb;
    in
    "${toString c.r},${toString c.g},${toString c.b}";
in
{
  services.kmscon.config = {
    palette = "custom";

    palette-black = color "base";
    palette-red = color "red";
    palette-green = color "green";
    palette-yellow = color "yellow";
    palette-blue = color "blue";
    palette-magenta = color "pink";
    palette-cyan = color "teal";
    palette-light-grey = color "text";

    palette-dark-grey = color "surface2";
    palette-light-red = color "red";
    palette-light-green = color "green";
    palette-light-yellow = color "yellow";
    palette-light-blue = color "blue";
    palette-light-magenta = color "pink";
    palette-light-cyan = color "teal";
    palette-white = color "lavender";

    palette-background = color "base";
    palette-foreground = color "text";
  };
}
