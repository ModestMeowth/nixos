{
  den.aspects.net._.wol = {
    nixos = {
      systemd.network.links."10-wol" = {
        matchConfig.Type = "ether";
        linkConfig.WakeOnLan = "magic";
      };
    };
  };
}
