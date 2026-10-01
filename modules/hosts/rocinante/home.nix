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

      programs.plasma = {
        configFile.kxkbrc = {
          Layout.Options = "compose:ralt,ctrl:swapcaps";
        };
      };
    };
  };
}
