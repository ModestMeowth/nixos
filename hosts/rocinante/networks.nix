let
  wifiInterface = "wlp2s0";
in
{
  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager = {
    enable = true;

    ensureProfiles."Ponyboy Bounce House".connection.interface-name = wifiInterface;
    ensureProfiles."Hyrule".connection.interface-name = wifiInterface;
  };
}
