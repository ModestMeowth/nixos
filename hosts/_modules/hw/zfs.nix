{ lib, config, ... }:
let
  cfg = config.modules.hw.zfs;
in
{
  options.modules.hw.zfs = {
    enable = lib.mkEnableOption "zfs";
    mountPoolsAtBoot = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {

    # ZFSBootMenu
    networking.hostId = "00bab10c";

    boot.supportedFilesystems = [ "zfs" ];
    boot.zfs = {
      forceImportRoot = false;
      extraPools = cfg.mountPoolsAtBoot;
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
