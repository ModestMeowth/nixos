{
  den.aspects.desktop._.plasma = {
    homeManager =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          input = {
            keyboard = {
              model = mkDefault "pc105";
              numlockOnStartup = mkDefault "on";
              options = [ "compose:ralt" ];
            };
          };

          configFile.kxkbrc.Layout.ResetOldOptions = mkDefault true;
        };
      };
  };
}
