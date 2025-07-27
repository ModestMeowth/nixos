{ config, lib, pkgs, ... }:
let cfg = config.monitoring;
in {
  services.prometheus = lib.mkIf cfg.enable {

    scrapeConfigs = [{
      job_name = "zfs";
      static_configs = [{
        targets = [
          "pwnyboy.cat-alkaline.ts.net:9134"
          "rocinante.cat-alkaline.ts.net:9134"
        ];
      }];
    }];

    ruleFiles = [
      (pkgs.writeText "zfs-rules" # yaml
        ''
          groups:
            - name: Zfs_exporter
              rules:
                - alert: ZfsPoolUnhealthy
                  expr: 'zfs_pool_health > 0'
                  for: 0m
                  labels:
                    severity: critical
                  annotations:
                    summary: ZFS pool unhealthy (instance {{ $labels.instance }})
                    description: ZFS pool state is {{ $value }}. See comments for more information.\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}
        '')
    ];
  };
}
