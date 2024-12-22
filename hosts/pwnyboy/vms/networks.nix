{lib, ...}: {
  networking.nftables.enable = lib.mkForce false;
}
