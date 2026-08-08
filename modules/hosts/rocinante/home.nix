{ den, inputs, ... }:
let
  wallpaper = inputs.self + /assets/wall.png;
in
{
  den.homes.x86_64-linux."mm@rocinante" = { };

  den.aspects.mm._.rocinante = {
    includes = with den.aspects.desktop._; [
      hyprland
      chromium
      ghostty
      walker
    ];

    homeManager = {
      nixpkgs.config.rocmSupport = true;

      theming.wallpaper = wallpaper;

      wayland.windowManager.hyprland.settings = {
        config = {
          general.layout = "master";
          input.kb_options = "ctrl:swapcaps";
        };

        monitor = [
          {
            output = "eDP-1";
            mode = "1920x1200";
            vrr = 3;
          }
        ];
      };

      services = {
        hyprpaper = {
          enable = true;
          settings = {
            splash = false;
            wallpaper = {
              output = "eDP-1";
              path = wallpaper;
            };
          };
        };

        hyprsunset = {
          enable = true;
          settings.profile.temperature = 3000;
        };
      };
    };
  };
}
