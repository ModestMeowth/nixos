{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  services.prometheus = lib.mkIf cfg.enable {
    scrapeConfigs = [
      {
        job_name = "smartctl";
        static_configs = [
          {
            targets = [
              "pwnyboy.cat-alkaline.ts.net:9633"
              "rocinante.cat-alkaline.ts.net:9633"
            ];
          }
        ];
      }
    ];

    ruleFiles = [
      (pkgs.writeText "smartctl-rules" # yaml
        ''
          groups:
            - name: SMARTCtl Exporter
              rules:
                - alert: SMART Test failed
                  expr: smartctl_device_smart_status != 1
                  for: 15m
                  labels:
                    severity: critical
                  annotations:
                    summary: SMART test failed (instance {{ $labels.instance }})
                    description: Device has failed smart test (instance {{ $labels.instance }})\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}
        '')
    ];
  };
}
