{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
  pfSenseIP = "192.168.0.1";
in
{
  services.prometheus = lib.mkIf cfg.enable {
    scrapeConfigs = [
      {
        job_name = "router_node";
        static_configs = [
          {
            targets = [
              "${pfSenseIP}:9100"
            ];
          }
        ];
      }
    ];

    ruleFiles = [
      (pkgs.writeText "router_node-rules" # yaml
        ''
          groups:
            - name: Node ROUTER
              rules:
                - alert: WAN Down
                  expr: node_pfsense_interface_up{name="wan"} != 1
                  for: 1m
                  labels:
                    severity: warning
                  annotations:
                    summary: Router WAN is down
                    description: Internet is out
        '')
    ];
  };
}
