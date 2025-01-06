{ config, lib, pkgs, ... }:
let
  cfg = config.wsl;
  cfgMonitoring = config.monitoring;
in
{
  config = lib.mkIf (!cfg.enable) {
    boot = {
      supportedFilesystems.zfs = true;
      zfs.forceImportRoot = false;
    };

    # ZFSBootMenu
    networking.hostId = "00bab10c";

    services = {
      zfs.autoScrub.enable = true;
      zfs.autoScrub.interval = "Sun, 2-5:00:00";
      zfs.autoScrub.randomizedDelaySec = "15m";
      zfs.trim.enable = true;

      prometheus = lib.mkIf cfgMonitoring.enable {
        exporters.zfs.enable = true;
        exporters.smartctl.enable = true;

        scrapeConfigs = [
          {
            job_name = "zfs";
            static_configs = [{ targets = [ ":9134" ]; }];
          }
          {
            job_name = "smartctl";
            static_configs = [{ targets = [ ":9633" ]; }];
          }
        ];

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
          (pkgs.writeText "smartctl-rules" #yaml
            ''
              groups:
                - name: Smartctl_exporter
                  rules:
                    - alert: SmartMediaErrors
                      expr: 'smartctl_device_media_errors > 0'
                      for: 15m
                      labels:
                        severity: critical
                      annotations:
                        summary: Smart media errors (instance {{ $labels.instance }})
                        description: "device has media errors (instance {{ $labels.instance }})\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
            '')
        ];
      };

      sanoid.enable = true;
      sanoid.templates = {
        default.autoprune = true;
        default.autosnap = true;

        default.hourly = 36;
        default.daily = 30;
        default.monthly = 3;
      };
    };

    environment.systemPackages = with pkgs; [
      smartmontools
      zfs-rebalance
    ];
  };
}
