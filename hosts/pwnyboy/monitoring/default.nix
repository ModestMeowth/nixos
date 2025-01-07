{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  imports = [
    ./node
    ./smartctl
    ./zfs

    ./nut.nix
    ./unifi.nix
  ];

  options.monitoring.enable = lib.mkEnableOption "monitoring";

  config.services.prometheus = lib.mkIf cfg.enable {
    enable = true;
  };
}
