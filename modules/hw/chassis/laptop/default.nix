{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.chassis == "laptop") {
    hostConfig.hw.wifi = true;
    hostConfig.misc.video = true;
    hostConfig.misc.sound = true;
  };
}
