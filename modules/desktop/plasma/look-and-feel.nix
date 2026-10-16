{inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    homeManager =
      { lib, ...}:
      let
        inherit (lib) mkDefault;
        wallpaper = "${inputs.self}/assets/black-cat.png";
      in
      {
        programs.plasma = {
          workspace = {
            wallpaper = wallpaper;
            splashScreen.theme = mkDefault "None";
          };

          kscreenlocker = {
            appearance.wallpaper = wallpaper;
            lockOnResume = mkDefault true;
            timeout = mkDefault 15;
          };

          kwin = {
            effects = {
              translucency.enable = mkDefault true;
            };

            nightLight = {
              enable = mkDefault true;
              mode = mkDefault "constant";
              temperature.night = mkDefault 3000;
            };
          };
        };
      };
  };
}
