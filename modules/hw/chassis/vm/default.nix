{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.chassis == "vm") {
    hostConfig.hw.cpu = "vm";
  };
}
