{config, lib, pkgs, ...}: let
  cfg = config.modules.monitoring.smartd;
  cfgExp = config.modules.monitoring.smartctl-exporter;
in {
  options.modules.monitoring.smartd.enable = lib.mkEnableOption "smartd";
  options.modules.monitoring.smartctl-exporter = {
    enable = lib.mkEnableOption "smartctl-exporter";
    port = lib.mkOption {
      type = lib.types.int;
      default = 9633;
    };
  };

  config = lib.mkIf cfg.enable {
    services.smartd.enable = true;

    services.prometheus.exporters.smartctl = lib.mkIf cfgExp.enable {
      enable = true;
      inherit (cfgExp) port;
    };

    environment.systemPackages = [ pkgs.smartmontools ];
  };
}
