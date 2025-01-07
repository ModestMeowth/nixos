{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  services.prometheus = lib.mkIf cfg.enable {
    exporters.nut.enable = true;

    scrapeConfigs = [{
      job_name = "nut";
      metrics_path = "/ups_metrics";
      static_configs = [{ targets = [ ":9199" ]; }];
    }];

    ruleFiles = [
      (pkgs.writeText "nut-rules" #yaml
        ''
          groups:
            - name: NUT ROUTER/PWNYBOY
              rules:
              - alert: UPS Down
                expr: network_ups_tools_status{flag!="OB"} > 0
                for: 0m
                labels:
                  severity: warning
                annotations:
                  summary: UPS on battery (instance {{ $labels.instance }})
                  description: UPS now running on battery (since {{$value | humanizeDuration}})\n VALUE = {{ $value }}\n LABELS = {{ $labels }}
        '')
    ];
  };
}
