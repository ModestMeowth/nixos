{
  den.aspects.desktop._.plasma = {
    homeManager = {
      programs.plasma = {
        kwin = {
          virtualDesktops = {
            number = 6;
          };
        };

        configFile.kwinrc.Plugins = {
          virtualdesktopsonlyonprimaryEnabled = true;
        };
      };
    };
  };
}
