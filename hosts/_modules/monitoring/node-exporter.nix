{ config, lib, ... }:
let

  cfg = config.modules.monitoring.node-exporter;

in
{
  options.modules.monitoring.node-exporter = {
    enable = lib.mkEnableOption "node-exporter";

    port = lib.mkOption {
      type = lib.types.int;
      default = 9100;
    };

  };

  config = lib.mkIf cfg.enable {
    services.prometheus.exporters.node = {
      enable = true;
      inherit (cfg) port;
    };
  };

}
