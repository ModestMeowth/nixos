{inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    homeManager =
      { lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          workspace = {
            wallpaper = "${inputs.self}/assets/black-cat.png";
            splashScreen.theme = mkDefault "None";
          };

          configFile = {
            kwinrc = {
              Effect-diminactive = {
                Strength = mkDefault 40;
              };

              NightColor = {
                Active = mkDefault true;
                Mode = mkDefault "Constant";
                NightTemperature = mkDefault 4000;
              };

              Plugins = {
                diminactiveEnabled = mkDefault false;
                translucencyEnabled = mkDefault true;
              };
            };
          };
        };
      };
  };
}
