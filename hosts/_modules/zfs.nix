{ config, lib, pkgs, ... }:
let
  cfg = config.wsl;
in
{
  config = lib.mkIf (!cfg.enable) {
    boot = {
      supportedFilesystems.zfs = true;
      zfs.forceImportRoot = false;
    };

    # ZFSBootMenu
    networking.hostId = "00bab10c";

    services = {
      zfs.autoScrub.enable = true;
      zfs.autoScrub.interval = "Sun, 2-5:00:00";
      zfs.autoScrub.randomizedDelaySec = "15m";
      zfs.trim.enable = true;

      prometheus.exporters.zfs.enable = true;

      sanoid.enable = true;
      sanoid.templates = {
        default.autoprune = true;
        default.autosnap = true;

        default.hourly = 36;
        default.daily = 30;
        default.monthly = 3;
      };
    };

    environment.systemPackages = with pkgs; [
      zfs-rebalance
    ];
  };
}
