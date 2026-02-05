{ config, lib, ... }:
let
  cfg = config.gaming.steam;
in
{
  options.gaming.steam = lib.mkEnableOption "steam";

  config = lib.mkIf cfg {
    programs = {
      steam.enable = true;
      steam.remotePlay.openFirewall = lib.mkDefault true;
      steam.dedicatedServer.openFirewall = lib.mkDefault true;
      steam.localNetworkGameTransfers.openFirewall = lib.mkDefault true;
    };
  };
}
