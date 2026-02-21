{
  ezModules,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ezModules.wireless
  ];

  environment.systemPackages = [ pkgs.raspberrypi-eeprom ];

  nix.settings = {
    builders-use-substitutes = lib.mkDefault true;
    max-jobs = lib.mkDefault 0;
  };
}
