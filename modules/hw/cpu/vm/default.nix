{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.cpu == "vm") {

  };
}
