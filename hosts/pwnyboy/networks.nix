{
  networking.bonds."bond0" = {
    interfaces = [ "enp3s0" "enp4s0" ];
    driverOptions.mode = "balance-alb";
  };

  networking.interfaces."bond0".useDHCP = true;
}
