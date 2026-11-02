{
  den.aspects.net = {
    nixos =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        systemd.network.networks."99-ethernet-default-dhcp".networkConfig.UseDomains = mkDefault "yes";
        networking.nftables.enable = mkDefault true;
      };
  };
}
