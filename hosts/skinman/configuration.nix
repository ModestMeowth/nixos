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

  services = {
    chronyd.enable = false;
    cockpit.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    technitium-dns-server = {
      enable = true;
      openFirewall = true;
    };
  };
}
