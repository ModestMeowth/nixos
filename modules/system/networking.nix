{
  hardware.wirelessRegulatoryDatabase = true;

  boot.extraModprobeConfig = ''
    options cfg80211 ieee80211_regdom="US"
  '';

  networking = {
    hostId = "00bab10c";
    networkmanager.enable = true;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
