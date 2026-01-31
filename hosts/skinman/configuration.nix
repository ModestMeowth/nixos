let
  wlan = "wlan0";
in
{
  imports = [ ./hardware-configuration.nix ];

  fleet = {
    isRpi = true;
    isServer = true;
  };

  networking = {
    hostName = "skinman";
    networkmanager.ensureProfiles.profiles = {
      "Ponyboy Bounce House".connection = {
        autoconnect = false;
        interface-name = wlan;
      };
    };
  };

  services = {
    cockpit = {
      enable = true;
      allowed-origins = [
        "https://skinman:9090"
        "https://skinman.threefinger.farm"
        "https://skinman.cat-alkaline.ts.net:9090"
      ];
      openFirewall = true;
    };

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
