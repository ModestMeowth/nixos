{config, lib, ...}:
let
  inherit (config.catppuccin) accent flavor sources;

  inherit (config.theming) fonts;

  palette = (lib.importJSON "${sources.palette}/palette.json").${flavor}.colors;

  quickshellTheme = builtins.concatStringsSep "\n"
    (lib.mapAttrsToList (n: v: ''  property color ${n}: "${v.hex}"'') palette);
in
{
  xdg.configFile."quickshell/Theme.qml".text = # qml
    ''
      import QtQuick
      
      QtObject {
        ${quickshellTheme};

        property color accent: ${accent}

        property color bg: base
        property color bgDim: mantle
        property color bgHover: surface0
        property color bgFocus: surface1
        property color fg: lavender
        property color fgMuted: surface2
        property color fgDim: text
        property color fgFocus: rosewater

        property color highlight: base
        property color shadow: lavender
        property color border: surface1
        property color selection: blue

        property color launcherBg: lavender
        property color launcherPrompt: green
        property color launcherText: mantle
        property color launcherSelectBlue: blue

        property color clipboardBg: lavender
        property color clipboardPrompt: green
        property color clipboardText: mantle

        property color topbarBg: lavender
        property color topbarWidgetBg: lavender
        property color topbarSliderBg: lavender
        property color topbarClockBg: lavender
        
        property string monospaceFont: "${fonts.monospace.name}"
        property string sansSerifFont: "${fonts.sansSerif.name}"
      }
  '';
}
