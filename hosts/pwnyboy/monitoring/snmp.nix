{config, lib, pkgs, ...}:
let
  cfg = config.monitoring;
in {
  services.prometheus = lib.mkIf cfg.enable {
    exporters.snmp.enable = true;
    exporters.snmp.configuration = {
      auths.public_v2 = {
        community = "public";
        version = 2;
      };
    };

    scrapeConfigs = [
      {
        job_name = "snmp_exporter";
        static_configs = [{ targets = [ ":9116" ]; }];
      }
      {
        job_name = "router";
        metrics_path = "/snmp";
        static_configs = [{ targets = [ "192.168.0.30:161" ]; }];
        params.auth = "public";
        relabel_configs = [
          {
            source_labels = "[__address__]";
            target_label = "__param_target";
          }
          {
            source_labels = "__param_target";
            target_label = "instance";
          }
          {
            source_labels = "__address__";
            replacement = "http://192.168.0.30:161";
          }
        ];
      }
    ];

    ruleFiles = [
      (pkgs.writeText "snmp-rules" # yaml
        ''
          groups:
            - name: snmp_exporter
        ''
      )
    ];
  };
}
