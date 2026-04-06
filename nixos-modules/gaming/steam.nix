{ config, lib, ... }:
let
  cfg = config.gaming.steam;
in
{
  programs.steam = lib.mkIf cfg {
      enable = true;
      remotePlay.openFirewall = lib.mkDefault true;
      dedicatedServer.openFirewall = lib.mkDefault true;
      localNetworkGameTransfers.openFirewall = lib.mkDefault true;
    };
}
