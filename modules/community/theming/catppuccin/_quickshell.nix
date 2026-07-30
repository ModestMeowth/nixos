{config, lib, ...}:
let
  inherit (config.catppuccin) accent flavor sources;

  inherit (config.theming) fonts;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;

  quickshellTheme = builtins.concatStringsSep "\n"
    (lib.mapAttrsToList (n: v: "  property color ${n}: ${v.hex}") palette);
in
{
  xdg.configFile."quickshell/Theme.qml".text = # qml
    ''
      import QtQuick
      
      QtObject {
      ${quickshellTheme};

        property color accent: ${accent}
        property color shadow: lavender

        property string font: "${fonts.monospace.name}"
      }
  '';
}
