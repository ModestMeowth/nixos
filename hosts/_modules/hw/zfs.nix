{ lib, config, ... }:
let
  cfg = config.boot.supportedFilesystems;
in
{
  config = lib.mkIf cfg.zfs {
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
  };
}
