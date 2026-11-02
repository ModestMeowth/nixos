{ den, ... }:
{
  den.homes.x86_64-linux."mm@rocinante" = { };

  den.aspects.mm._.rocinante = {
    includes = with den.aspects; [
      wm.plasma.plugins.krohnkite

      term.ghostty
      media.mpv
      www.chromium
    ];

    nixos = {
      users.users.mm.extraGroups = [
        "gamemode"
        "lp"
        "scanner"
        "wireshark"
      ];
    };

    homeManager = {
      programs = {
        plasma = {
          input = {
            keyboard.options = [ "ctrl:swapcaps" ];
            touchpads = [
              {
                enable = true;
                name = "SYNA801A:00 06CB:CEC6 Touchpad";
                vendorId = "06cb";
                productId = "cec6";
                naturalScroll = true;
              }
            ];
          };
        };
      };
    };
  };
}
