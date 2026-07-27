{
  den.aspects.networking = {
    nixos = {
      systemd.network.networks."99-ethernet-default-dhcp".networkConfig.UseDomains = "yes";
      networking.nftables.enable = true;
    };

    _.static.nixos = {
      networking.tempAddresses = "disabled";
    };

    _.wol.nixos = {
      systemd.network.links."10-wol" = {
        matchConfig.Type = "ether";
        linkConfig.WakeOnLan = "magic";
      };
    };

    _.wireless.nixos =
      { lib, ... }:
      {
        systemd.network.enable = lib.mkForce false;
        networking.networkmanager = {
          enable = true;
          wifi.backend = "iwd";
        };
      };
  };
}
