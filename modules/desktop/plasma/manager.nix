{den, inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    includes = with den.aspects; [
      desktop
    ];

    homeManager =
      { lib, ... }:
      {
        programs.plasma = {
          enable = true;
          overrideConfig = true;

          configFile = {
            kxkbrc.Layout = {
              Options = lib.mkDefault "compose:ralt";
              ResetOldOptions = true;
            };
          };

          workspace = {
            clickItemTo = lib.mkDefault "select";

            wallpaper = "${inputs.self}/assets/black-cat.png";
          };

          panels = [
            {
              location = "bottom";
              widgets = [
                {
                  name = "org.kde.plasma.kickoff";
                }
                {
                  iconTasks = {
                    
                    launchers = [
                      "applications:org.kde.dolphin.desktop"
                      "applications:org.kde.konsole.desktop"
                    ];
                  };
                }
              ];
            }
          ];
        };
      };
  };
}
