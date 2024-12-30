let
  wifiInterface = "wlp2s0";
in
{
  systemd = {
    services.NetworkManager-wait-online.enable = false;
  };

  networking = {
    hostName = "rocinante";

    networkmanager.enable = true;
    networkmanager.ensureProfiles.profiles = {
      "Ponyboy Bounce House".connection.interface-name = wifiInterface;
      "Hyrule".connection.interface-name = wifiInterface;
    };
  };
}
