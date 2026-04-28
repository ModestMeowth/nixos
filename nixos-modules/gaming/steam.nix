{ config, lib, ... }:
let
  cfg = config.gaming.steam;
in
{
  config = lib.mkIf cfg {
    boot.kernelModules = [ "ntsync" ];
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = lib.mkDefault true;
      dedicatedServer.openFirewall = lib.mkDefault true;
      localNetworkGameTransfers.openFirewall = lib.mkDefault true;
    };
  };
}
