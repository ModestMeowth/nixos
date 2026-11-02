{ den, ... }:
{
  den.aspects.boot._.secure = {
    includes = [ den.aspects.boot ];

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
