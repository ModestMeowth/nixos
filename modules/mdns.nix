{
  den.default = {
    nixos =
      { lib, ... }:
      {
        services.avahi = {
          enable = lib.mkDefault true;
          nssmdns4 = true;
          openFirewall = true;
          publish = {
            enable = true;
            domain = true;
            hinfo = true;
            userServices = true;
            workstation = true;
          };
        };
      };
  };
}
