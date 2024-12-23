let
  bridge = "bridge0";
  cidr = "192.168.0";
  prefix = 24;
in {
  networking.bridges."${bridge}".interfaces = [ "enp3s0" ];

  networking.interfaces."enp3s0".useDHCP = false;
  networking.interfaces."enp4s0".useDHCP = false;

  networking.interfaces."${bridge}".ipv4.addresses = [
    {
      address = "${cidr}.30";
      prefixLength = prefix;
    }
  ];

  networking.defaultGateway = {
    address = "${cidr}.1";
    interface = "${bridge}";
  };

  networking.nameservers = [
    "${cidr}.1"
    "1.1.1.1"
  ];

  networking.firewall.trustedInterfaces = ["tailscale+"];
}
