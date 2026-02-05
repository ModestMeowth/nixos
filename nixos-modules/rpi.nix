{ezModules, lib, pkgs, ...}: {
  imports = [
    ezModules.networkmanager
  ];

  environment.systemPackages = [pkgs.raspberrypi-eeprom];

  networking.networkmanager.enable = lib.mkDefault true;

  nix.settings = {
    builders-use-substitutes = lib.mkDefault true;
    max-jobs = lib.mkDefault 0;
  };
}
