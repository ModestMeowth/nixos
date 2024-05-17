{
  networking = {
    hostId = "00bab10c";
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
