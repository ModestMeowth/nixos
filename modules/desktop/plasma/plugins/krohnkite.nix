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
              screenGapBottom = mkDefault 10;
              screenGapLeft = mkDefault 10;
              screenGapRight = mkDefault 10;
              screenGapTop = mkDefault 10;
            };
          };

          shortcuts.kwin = {
            KrohnkiteBTreeLayout = mkDefault [ ];
            KrohnkiteColumnsLayout = mkDefault [ ];
            KrohnkiteDecrease = mkDefault [ ];
            KrohnkiteFloatAll = mkDefault [ ];
            KrohnkiteFloatingLayout = mkDefault [ ];
            KrohnkiteFocusDown = mkDefault "Meta+J";
            KrohnkiteFocusLeft = mkDefault "Meta+H";
            KrohnkiteFocusNext = mkDefault [ ];
            KrohnkiteFocusPrev = mkDefault [ ];
            KrohnkiteFocusRight = mkDefault "Meta+L";
            KrohnkiteFocusUp = mkDefault "Meta+K";
            KrohnkiteGrowHeight = mkDefault [ ];
            KrohnkiteIncrease = mkDefault [ ];
            KrohnkiteMonocleLayout = mkDefault "Meta+F";
            KrohnkiteNextLayout = mkDefault [ ];
            KrohnkitePreviousLayout = mkDefault [ ];
            KrohnkiteQuarterLayout = mkDefault [ ];
            KrohnkiteRotate = mkDefault [ ];
            KrohnkiteRotatePart = mkDefault [ ];
            KrohnkiteSetMaster = mkDefault [ ];
            KrohnkiteShiftDown = mkDefault "Meta+Shift+J";
            KrohnkiteShiftLeft = mkDefault "Meta+Shift+H";
            KrohnkiteShiftRight = mkDefault "Meta+Shift+L";
            KrohnkiteShiftUp = mkDefault "Meta+Shift+K";
            KrohnkiteShrinkHeight = mkDefault [ ];
            KrohnkiteShrinkWidth = mkDefault [ ];
            KrohnkiteSpiralLayout = mkDefault [ ];
            KrohnkiteSpreadLayout = mkDefault [ ];
            KrohnkiteStackedLayout = mkDefault [ ];
            KrohnkiteStairLayout = mkDefault [ ];
            KrohnkiteTileLayout = mkDefault [ ];
            KrohnkiteToggleFloat = mkDefault [ ];
            KrohnkiteTreeColumnLayout = mkDefault [ ];
            KrohnkitegrowWidth = mkDefault [ ];
            KrohnkitetoggleDock = mkDefault [ ];
          };
        };
      };
  };
}
