{config, lib, ...}:
let
  cfg = config.fleet.isDesktop;
in
{
  options.fleet.isServer = lib.mkEnableOption "device is a server";

  config = lib.mkIf cfg {
  };
}
