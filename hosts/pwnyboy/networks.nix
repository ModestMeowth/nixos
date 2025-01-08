let
  bridge = "bridge0";
  cidr = "192.168.0";
  prefix = 24;
in
{
  networking = {
    hostName = "pwnyboy";
    bridges."${bridge}".interfaces = [ "enp3s0" ];

    interfaces."enp3s0".useDHCP = false;
    interfaces."enp4s0".useDHCP = false;

    interfaces."${bridge}".ipv4.addresses = [
      {
        address = "${cidr}.30";
        prefixLength = prefix;
      }
    ];

    defaultGateway = {
      address = "${cidr}.1";
      interface = "${bridge}";
    };

    nameservers = [
      "${cidr}.1"
      "1.1.1.1"
    ];

    firewall = {
      trustedInterfaces = [
        "tailscale0"
        "docker0"
      ];

      allowedTCPPorts = [
        80
        443 # HTTP
        53
        853 # DNS over TCP
        8123 # HomeAssistant
        22000 # Syncthing
      ];

      allowedUDPPorts = [
        53 # DNS
        22000
        21027 # Syncthing
      ];
    };
  };
}
