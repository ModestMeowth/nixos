let
  wlan = "wlan0";
in
{
  imports = [ ./hardware-configuration.nix ];

  fleet.isRpi = true;

  networking = {
    hostName = "skinman";
    networkmanager.ensureProfiles.profiles."Ponyboy Bounce House".connection.interface-name = wlan;
  };

  services.tailscale.enable = true;
}
