{
  den.aspects.svc.cockpit = {
    nixos =
      { lib, ... }:
      {
        services.cockpit = {
          enable = lib.mkDefault true;
          openFirewall = lib.mkDefault true;
        };
      };
  };
}
