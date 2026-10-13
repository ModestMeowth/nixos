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
            # "org.kde.powerdevil".display = mkDefault [];

            ksmserver = {
              "Lock Session" = "Meta+Shift+L";
            };

            kwin = {
              "Switch to Desktop 1" = "Meta+1";
              "Switch to Desktop 2" = "Meta+2";
              "Switch to Desktop 3" = "Meta+3";
              "Switch to Desktop 4" = "Meta+4";
              "Switch to Desktop 5" = "Meta+5";
              "Switch to Desktop 6" = "Meta+6";

              "Window to Desktop 1" = "Meta+!";
              "Window to Desktop 2" = "Meta+@";
              "Window to Desktop 3" = "Meta+#";
              "Window to Desktop 4" = "Meta+$";
              "Window to Desktop 5" = "Meta+%";
              "Window to Desktop 6" = "Meta+^";

              "Show Desktop" = [ ];
            };

            plasmashell = {
              "activate task manager entry 1" = [];
              "activate task manager entry 2" = [];
              "activate task manager entry 3" = [];
              "activate task manager entry 4" = [];
              "activate task manager entry 5" = [];
              "activate task manager entry 6" = [];
              "activate task manager entry 7" = [];
              "activate task manager entry 8" = [];
              "activate task manager entry 9" = [];
              "activate task manager entry 10" = [];
            };
          };
        };
      };
  };
}
