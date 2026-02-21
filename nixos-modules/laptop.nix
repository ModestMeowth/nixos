{ ezModules, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.brightnessctl ];

  imports = [ ezModules.wireless ];

  services.power-profiles-daemon.enable = true;

  services.kmscon.extraOptions = ''--xkb-options="ctrl:swapcaps"'';
}
