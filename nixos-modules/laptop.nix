{ lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.brightnessctl ];
  networking.networkmanager.enable = lib.mkDefault true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery.governor = "powersave";
      battery.turbo = "never";

      charger.governor = "performance";
      charger.turbo = "auto";
    };
  };
}
