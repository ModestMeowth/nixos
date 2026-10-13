{den, inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    includes = with den.aspects; [
      desktop
    ];

    homeManager =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          enable = true;
          overrideConfig = mkDefault true;
        };
      };
  };
}
