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

  config = lib.mkIf cfg.enable {
    services = {
      prometheus.enable = true;
      prometheus.webExternalUrl = "https://metrics.pwnyboy.com";
    };

    networking.firewall.allowedTCPPorts = [ config.services.prometheus.port ];
  };
}
