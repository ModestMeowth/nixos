{inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    homeManager =
      { lib, ...}:
      {
        programs.plasma = {
          configFile = {
            kwinrc = {
              Effect-diminactive.Strength = lib.mkDefault 40;
              NightColor = {
                Active = lib.mkDefault true;
                Mode = lib.mkDefault "Constant";
                NightTemperature = lib.mkDefault 4000;
              };

              Plugins = {
                diminactiveEnabled = lib.mkDefault true;
                translucencyEnabled = lib.mkDefault true;
              };
            };

            plasmarc.Wallpapers.userWallpapers = "${inputs.self}/assets/black-cat.png";
          };
        };
      };
  };
}
