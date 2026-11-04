{inputs, lib, ...}:
let
  inherit (lib) mkDefault;
  wallpaper = "${inputs.self}/assets/black-cat.png";
in
{
  den.aspects.wm.plasma = {
    nixos = {
      environment.etc."plasmalogin.conf" = {
        enable = true;
        text = ''
          [Greeter]
          PreselectedSession=

          [Greeter][Wallpaper][org.kde.image][General]
          Image=file://${wallpaper}
        '';

        mode = "644";
      };
    };

    homeManager =
    {
      programs.plasma = {
        workspace = {
          wallpaper = wallpaper;
          splashScreen.theme = mkDefault "None";
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

        kscreenlocker = {
          lockOnResume = mkDefault true;
          timeout = mkDefault 15;
        };

        configFile = {
          kscreenlockerrc = {
            "Greeter/Wallpaper/org.kde.image/General".Image = wallpaper;
          };
        };
      };
    };
  };
}
