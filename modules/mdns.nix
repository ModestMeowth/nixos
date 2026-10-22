{
  den.default = {
    nixos =
      { lib, ... }:
      {
        services.avahi = {
          enable = lib.mkDefault true;
          nssmdns4 = true;
          openFirewall = true;
          settings.publish = {
            disable-publishing = false;
            disable-user-service-publishing = false;

            publish-domain = true;
            publish-hinfo = true;
            publish-workstation = true;
          };
        };
      };
  };
}
