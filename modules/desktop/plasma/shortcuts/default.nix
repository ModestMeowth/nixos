{
  den.aspects.desktop._.plasma = {
    homeManager =
      {lib, ...}:
      let
        mkEmptyDefault =
          list:
            lib.genAttrs list (item: lib.mkDefault [ ]);
      in
      {
        programs.plasma.shortcuts = {
          kaccess = mkEmptyDefault [
            "Toggle Screen Reader On and Off"    # Meta+Alt+S
          ];

          kwin = mkEmptyDefault [
            "Edit Tiles"                         # Meta+T
            "Expose"                             # Ctrl+F9, Meta+F9
            "ExposeAll"                          # Launch (C), Ctrl+F10, Meta+F10
            "ExposeClass"                        # Ctrl+F7, Meta+F7
            "Kill Window"                        # Meta+Ctrl+Esc
            "Overview"                           # Meta+W
            "Show Desktop"                       # Meta+D

            "Switch One Desktop Down"            # Meta+Ctrl+Down
            "Switch One Desktop Up"              # Meta+Ctrl+Up
            "Switch One Desktop to the Left"     # Meta+Ctrl+Left
            "Switch One Desktop to the Right"    # Meta+Ctrl+Right

            "Switch One Window Down"             # Meta+Alt+Down
            "Switch One Window Left"             # Meta+Alt+Left
            "Switch One Window Right"            # Meta+Alt+Right
            "Switch One Window Up"               # Meta+Alt+Up

            "Window One Desktop Down"            # Meta+Ctrl+Shift+Down
            "Window One Desktop Up"              # Meta+Ctrl+Shift+Up
            "Window One Desktop to the Left"     # Meta+Ctrl+Shift+Left
            "Window One Desktop to the Right"    # Meta+Ctrl+Shift+Right

            "Window Operations Menu"             # Alt+F3
            "Window Restore"                     # Meta+Backspace
          ];

          plasmashell = mkEmptyDefault [
            "activate application launcher"      # Meta, Alt+F1

            "activate task manager entry 1"      # Meta+1
            "activate task manager entry 2"      # Meta+2
            "activate task manager entry 3"      # Meta+3
            "activate task manager entry 4"      # Meta+4
            "activate task manager entry 5"      # Meta+5
            "activate task manager entry 6"      # Meta+6
            "activate task manager entry 7"      # Meta+7
            "activate task manager entry 8"      # Meta+8
            "activate task manager entry 9"      # Meta+9

            "cycle-panels"                       # Meta+Alt+P
            "manage activities"                  # Meta+Q
            "next activity"                      # Meta+A
            "previous activity"                  # Meta+Shift+A
            "show dashboard"                     # Ctrl+F12
          ];

          "services/org.kde.krunner.desktop" = mkEmptyDefault [
            "Launch"                             # Alt+Space, Alt+F2, Search
            "Run command on clipboard contents"  # Alt+Shift+F2
          ];
        };
    };
  };
}
