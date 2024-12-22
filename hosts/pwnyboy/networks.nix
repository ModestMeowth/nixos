{
  networking.bonds."bond0" = {
    interfaces = [ "enp3s0" "enp4s0" ];
    driverOptions.mode = "balance-alb";
  };

  networking.interfaces."bond0" = {
    macAddress = "a8:b8:e0:05:a6:02";
  };
}
