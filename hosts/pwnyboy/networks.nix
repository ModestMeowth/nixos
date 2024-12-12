let
  net_if = "bond0";
  cidr = "192.168.0";
  prefix = 24;
in {
  networking.bonds.${net_if}.interfaces = [ "enp3s0" "enp4s0" ];
  networking.bonds.${net_if}.driverOptions.mode = "balance-alb";

  networking.${net_if}.ipv4.addesses = [{
    address = "${cidr}.30";
    prefixLength = prefix;
  }];

  networking.defaultGateway = {
    address = "${cidr}.1";
    interface = net_if;
  };
}
