{ lib, ... }: {
  networking = {
    nftables.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    firewall.allowedUDPPortRanges = [{
      # Mosh
      from = 60000;
      to = 61000;
    }];
  };
}
