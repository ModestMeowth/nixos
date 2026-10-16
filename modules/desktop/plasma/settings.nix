{
  den.aspects.desktop._.plasma = {
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
            systemsettingsrc.systemsettings_sidebar_mode.HighlightNonDefaultSettings = mkDefault true;
          };
        };
      };
  };
}
