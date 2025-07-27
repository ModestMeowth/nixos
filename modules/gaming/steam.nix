{ config, lib, pkgs, ... }:
let cfg = config.gaming.steam;
in {
  options.gaming.steam.enable = lib.mkEnableOption "steam";

  config.programs.steam = lib.mkIf cfg.enable {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
