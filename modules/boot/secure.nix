{ den, ... }:
{
  den.aspects.boot.secure = {
    includes = with den.aspects; [ boot ];

    nixos =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        boot.loader.limine.secureBoot = {
          enable = mkDefault true;
          autoGenerateKeys = mkDefault true;
          autoEnrollKeys.enable = mkDefault true;
        };
      };
  };
}
