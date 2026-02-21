{ ezModules, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.brightnessctl ];

  imports = [ ezModules.wireless ];

  services.power-profiles-daemon.enable = true;
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery.governor = "powersave";
  #     battery.turbo = "never";

  #     charger.governor = "performance";
  #     charger.turbo = "auto";
  #   };
  # };
}
