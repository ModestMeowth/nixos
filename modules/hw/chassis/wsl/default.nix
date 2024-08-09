{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.chassis == "wsl") {
    hostConfig.hw.cpu = "wsl";
  };
}
