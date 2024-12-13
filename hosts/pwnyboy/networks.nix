let
  net_if = "bond0";
  cidr = "192.168.0";
  prefix = 24;
in
{
  networking.bonds.${net_if} = {
    interfaces = [ "enp3s0" "enp4s0" ];
    driverOptions.mode = "balance-alb";
  };

  networking.interfaces.${net_if}.ipv4.addresses = [{
    address = "${cidr}.30";
    prefixLength = prefix;
  }];

  networking.defaultGateway = {
    address = "${cidr}.1";
    interface = net_if;
  };
}
