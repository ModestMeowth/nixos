{
  den.aspects.wm.plasma = {
    homeManager =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          workspace = {
            clickItemTo = mkDefault "select";
          };

          configFile = {
            kwinrc = {
              General = {
                AudioFeedback = mkDefault false;
                VolumeStep = mkDefault 2;
              };
            };

            dolphinrc = {
              General = {
                BrowseThroughArchives = mkDefault true;
                RememberOpenedTabs = mkDefault false;
              };
            };

            kwinrc = {
              Windows.PerOutputVirtualDesktops = mkDefault true;
            };

            systemsettingsrc.systemsettings_sidebar_mode.HighlightNonDefaultSettings = mkDefault true;
          };
        };
      };
  };
}
