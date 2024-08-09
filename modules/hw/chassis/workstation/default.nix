{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.chassis == "workstation") {
    hostConfig.misc.video = true;
    hostConfig.misc.sound = true;
  };
}
