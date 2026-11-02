{
  den.aspects.svc.printing = {
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
