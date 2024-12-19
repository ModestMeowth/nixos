{ config, lib, pkgs, ... }:
let
  cfg = config.wsl;
in
{
  config = lib.mkIf (!cfg.enable) {
    boot.supportedFilesystems.zfs = true;

    # ZFSBootMenu
    networking.hostId = "00bab10c";

    boot.zfs = {
      forceImportRoot = false;
    };

    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    services.sanoid = {
      enable = true;
      templates.default = {
        autoprune = true;
        autosnap = true;

        hourly = 36;
        daily = 30;
        monthly = 3;
      };
    };

    environment.systemPackages = [pkgs.zfs-rebalance];
  };
}
