{ config, lib, ... }:
let
  cfg = config.fleet.isRpi;
in
{
  options.fleet.isRpi = lib.mkEnableOption "device is a raspberry pi";

  config = lib.mkIf cfg {
    networking.networkmanager.enable = true;
  };
}
