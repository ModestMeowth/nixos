{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  imports = [
    ./node.nix
    ./nut.nix
    ./smartctl.nix
    ./unifi.nix
    ./zfs.nix
  ];

  options.monitoring.enable = lib.mkEnableOption "monitoring";

  config.services.prometheus = lib.mkIf cfg.enable {
    enable = true;
  };
}
