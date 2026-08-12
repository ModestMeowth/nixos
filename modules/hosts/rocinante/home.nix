{ den, ... }:
{
  den.homes.x86_64-linux."mm@rocinante" = { };

  den.aspects.mm._.rocinante = {
    includes = with den.aspects.desktop._; [
      dms._.hyprland
      chromium
      ghostty
    ];

    homeManager = {
      nixpkgs.config.rocmSupport = true;

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
    };
  };
}
