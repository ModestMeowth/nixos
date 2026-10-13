{
  den.aspects.desktop._.plasma = {
    homeManager =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          shortcuts = {
            kwin = {
              "Switch to Desktop 1" = mkDefault [ "Meta+1" ];
              "Switch to Desktop 2" = mkDefault [ "Meta+2" ];
              "Switch to Desktop 3" = mkDefault [ "Meta+3" ];
              "Switch to Desktop 4" = mkDefault [ "Meta+4" ];
              "Switch to Desktop 5" = mkDefault [ "Meta+5" ];
              "Switch to Desktop 6" = mkDefault [ "Meta+6" ];

              "Window to Desktop 1" = mkDefault [ "Meta+!" ];
              "Window to Desktop 2" = mkDefault [ "Meta+@" ];
              "Window to Desktop 3" = mkDefault [ "Meta+#" ];
              "Window to Desktop 4" = mkDefault [ "Meta+$" ];
              "Window to Desktop 5" = mkDefault [ "Meta+%" ];
              "Window to Desktop 6" = mkDefault [ "Meta+^" ];

              "Window Close" = mkDefault [ "Meta+W" ];
            };
          };
        };
      };
  };
}
