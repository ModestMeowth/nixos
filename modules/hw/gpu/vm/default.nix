{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hwConfig.hw.gpu == "vm") {
  };
}
