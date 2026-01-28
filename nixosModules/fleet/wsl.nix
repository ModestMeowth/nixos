{config, lib, ...}:
let
  cfg = config.fleet.isWsl;
in
{
  options.fleet.isWsl = lib.mkEnableOption "device is WSL";

  config = lib.mkIf cfg {
    services.chrony.enable = lib.mkForce false;
  };
}
