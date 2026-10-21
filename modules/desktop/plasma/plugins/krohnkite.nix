{
  den.aspects.desktop._.plasma._.krohnkite = {
    homeManager =
      { lib, pkgs, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        home.packages = [ pkgs.kdePackages.krohnkite ];

        programs.plasma = {
          configFile.kwinrc = {
            Plugins.krohnkiteEnabled = true;
            Script-krohnkite = {
              adjustLayout = mkDefault false;
              adjustLayoutLive = mkDefault false;
              screenGapBottom = mkDefault 0;
              screenGapLeft = mkDefault 0;
              screenGapRight = mkDefault 0;
              screenGapTop = mkDefault 0;
              screenGapBetween = mkDefault 10;
              soleWindowNoBorders = mkDefault true;
              soleWindowNoGaps = mkDefault true;
            };
          };

          shortcuts.kwin = {
            KrohnkiteSetMaster = mkDefault [ "Meta+M" ];
            KrohnkiteIncrease = mkDefault [ "Meta+N" ];
            KrohnkiteDecrease = mkDefault [ "Meta+Shift+N" ];


            KrohnkiteFocusLeft = mkDefault [ "Meta+H" ];
            KrohnkiteFocusDown = mkDefault [ "Meta+J" ];
            KrohnkiteFocusUp = mkDefault [ "Meta+K" ];
            KrohnkiteFocusRight = mkDefault [ "Meta+L" ];

            KrohnkiteShiftLeft = mkDefault [ "Meta+Shift+H" ];
            KrohnkiteShiftDown = mkDefault [ "Meta+Shift+J" ];
            KrohnkiteShiftUp = mkDefault [ "Meta+Shift+K" ];
            KrohnkiteShiftRight = mkDefault [ "Meta+Shift+L" ];

            KrohnkitegrowWidth = mkDefault [ "Meta+Ctrl+H" ];
            KrohnkiteShrinkHeight = mkDefault [ "Meta+Ctrl+J" ];
            KrohnkiteGrowHeight = mkDefault [ "Meta+Ctrl+K" ];
            KrohnkiteShrinkWidth = mkDefault [ "Meta+Ctrl+L" ];

            KrohnkiteMonocleLayout = mkDefault [ "Meta+F" ];
            KrohnkiteTileLayout = mkDefault [ "Meta+M" ];
            KrohnkiteToggleFloat = mkDefault [ "Meta+P" ];

            KrohnkiteFloatAll = mkDefault [ ];
            KrohnkiteFloatingLayout = mkDefault [ ];
            KrohnkiteFocusNext = mkDefault [ ];
            KrohnkiteFocusPrev = mkDefault [ ];
            KrohnkiteBTreeLayout = mkDefault [ ];
            KrohnkiteColumnsLayout = mkDefault [ ];
            KrohnkiteNextLayout = mkDefault [ ];
            KrohnkitePreviousLayout = mkDefault [ ];
            KrohnkiteQuarterLayout = mkDefault [ ];
            KrohnkiteRotate = mkDefault [ ];
            KrohnkiteRotatePart = mkDefault [ ];
            KrohnkiteSpiralLayout = mkDefault [ ];
            KrohnkiteSpreadLayout = mkDefault [ ];
            KrohnkiteStackedLayout = mkDefault [ ];
            KrohnkiteStairLayout = mkDefault [ ];
            KrohnkiteTreeColumnLayout = mkDefault [ ];
            KrohnkitetoggleDock = mkDefault [ ];
          };
        };
      };
  };
}
