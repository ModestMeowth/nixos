{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  services.prometheus = lib.mkIf cfg.enable {
    scrapeConfigs = [{
      job_name = "node";
      static_configs = [
        {
          targets = [
            "pwnyboy.cat-alkaline.ts.net:9100"
            "rocinante.cat-alkaline.ts.net:9100"
            "192.168.0.1:9100"
          ];
        }
      ];
    }];

    ruleFiles = [
      (pkgs.writeText "node-rules" # yaml
        ''
          groups:
            - name: Node PWNYBOY
              rules:
                - alert: Memory Pressure
                  expr: '(rate(node_vmstat_pgmajfault[1m]) > 1000) * on(instance) group_left (nodename) node_uname_info{nodename=~".+"}'
                  for: 2m
                  labels:
                    severity: warning
                  annotations:
                    summary: Host memory under memory pressure (instance {{ $labels.instance }})
                    description: The node is under heavy memory pressure. High rate of major page faults\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}
                - alert: Hight CPU Load
                  expr: '(sum by (instance) (avg by (mode, instance) (rate(node_cpu_seconds_total{mode!="idle"}[2m]))) > 0.8) * on(instance) group_left (nodename) node_uname_info{nodename=~".+"}'
                  for: 10m
                  labels:
                    severity: warning
                  annotations:
                    summary: Host high CPU load (instance {{ $labels.instance }})
                    description: "CPU load is > 80%\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
        ''
      )
    ];
  };
}
