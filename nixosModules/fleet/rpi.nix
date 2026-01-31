{ config, lib, ... }:
let
  cfg = config.fleet.isRpi;
in
{
  options.fleet.isRpi = lib.mkEnableOption "device is a raspberry pi";

  config = lib.mkIf cfg {
    nix.settings.max-jobs = 0;
    networking.networkmanager.enable = true;

    services = {
      chrony.enable = lib.mkForce false;
    };
  };
}
