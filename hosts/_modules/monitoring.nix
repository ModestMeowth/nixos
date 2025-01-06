{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  options.monitoring.enable = lib.mkEnableOption "monitoring";

  config.services = lib.mkIf cfg.enable {
    prometheus.enable = true;

    prometheus.exporters = {
      node.enable = true;
      node.enabledCollectors = [ "systemd" ];
    };

    prometheus.scrapeConfigs = [{
      job_name = "node";
      static_configs = [{ targets = [ ":9100" ]; }];
    }];

    prometheus.ruleFiles = [
      (pkgs.writeText "node-rules" # yaml
        ''
          groups:
            - name: Node_exporter
              rules:
                - alert: HostMemoryUnderMemoryPressure
                  expr: '(rate(node_vmstat_pgmajfault[1m]) > 1000) * on(instance) group_left (nodename) node_uname_info{nodename=~".+"}'
                  for: 2m
                  labels:
                    severity: warning
                  annotations:
                    summary: Host memory under memory pressure (instance {{ $labels.instance }})
                    description: The node is under heavy memory pressure. High rate of major page faults\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}
                - alert: HostHighCpuLoad
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
