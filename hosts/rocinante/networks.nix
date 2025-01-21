let
  wifiInterface = "wlp2s0";
in
{
  services = {
    resolved.enable = true;
    resolved.dnssec = "true";
    resolved.dnsovertls = "opportunistic";
    resolved.extraConfig = ''
      [Resolve]
      MulticastDNS=yes
    '';
  };

  networking = {
    hostName = "rocinante";

    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    networkmanager.ensureProfiles.profiles = {
      "Ponyboy Bounce House".connection.interface-name = wifiInterface;
      "Hyrule".connection.interface-name = wifiInterface;
    };
  };
}
