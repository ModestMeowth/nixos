{ config, lib, ... }:
let
  cfg = config.fleet.isLaptop;
in
{
  options.fleet.isLaptop = lib.mkEnableOption "device is a laptop";

  config = lib.mkIf cfg {
    networking.networkmanager.enable = true;

    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery.governor = "powersave";
        battery.turbo = "never";

        charger.governor = "performance";
        charger.turbo = "auto";
      };
    };
  };
}
