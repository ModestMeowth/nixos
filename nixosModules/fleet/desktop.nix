{config, lib, ...}:
let
  cfg = config.fleet.isDesktop;
in
{
  options.fleet.isDesktop = lib.mkEnableOption "device is desktop";

  config = lib.mkIf cfg {

  };
}
