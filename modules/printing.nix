{
  den.aspects.printing.default = {
    nixos =
      {lib, pkgs, ...}:
      {
        environment.systemPackages = [ pkgs.cups-pk-helper ];

        hardware.sane.enable = lib.mkDefault true;

        services.printing = {
          enable = true;
        };
      };
  };
}
