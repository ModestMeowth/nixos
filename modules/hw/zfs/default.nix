{
  config,
  lib,
  ...
}: {
  options.hostConfig.hw = {
    zfs = lib.mkEnableOption "zfs";
  };

  config = lib.mkIf config.hostConfig.hw.zfs {
    networking.hostId = "00bab10c";
  };
}
