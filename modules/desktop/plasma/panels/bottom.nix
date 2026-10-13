{
  den.aspects.desktop._.plasma = {
    homeManager = {
      programs.plasma.panels = [
        {
          lengthMode = "fill";
          location = "bottom";
          opacity = "translucent";

          widgets = [
            {
              name = "org.kde.plasma.kickoff";
            }
            {
              iconTasks = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:com.mitchellh.ghostty.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                time.format = "24h";
              };
            }
          ];
        }
      ];
    };
  };
}
