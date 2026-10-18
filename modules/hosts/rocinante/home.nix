{ den, ... }:
{
  den.homes.x86_64-linux."mm@rocinante" = { };

  den.aspects.mm._.rocinante = {
    includes = with den.aspects.desktop._; [
      plasma
      plasma._.krohnkite
      chromium
      ghostty
    ];

    homeManager = {
      nixpkgs.config.rocmSupport = true;

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
