{ lib, ... }:
{
  den.aspects.hw.fs = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.smartmontools ];

        services.smartd.enable = lib.mkDefault true;
      };
  };
}
