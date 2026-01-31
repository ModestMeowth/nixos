{ config, lib, pkgs, ... }:
let
  cfg = config.fleet.isRpi;
in
{
  options.fleet.isRpi = lib.mkEnableOption "device is a raspberry pi";

  config = lib.mkIf cfg {
    environment.systemPackages = with pkgs; [
      raspberrypi-eeprom
    ];

    nix.settings.max-jobs = lib.mkDefault 0;
    networking.networkmanager.enable = lib.mkDefault true;

    services = {
      chrony.enable = lib.mkForce false;
    };
  };
}
