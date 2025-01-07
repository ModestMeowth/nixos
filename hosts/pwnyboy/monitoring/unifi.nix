{ config, lib, pkgs, ... }:
let
  cfg = config.monitoring;
in
{
  config = lib.mkIf cfg.enable {
    sops.secrets = {
      "unpoller-pass".mode = "0400";
      "unpoller-pass".owner = config.services.prometheus.exporters.unpoller.user;
      "unpoller-pass".group = config.services.prometheus.exporters.unpoller.group;
    };

    services.prometheus = {
      exporters.unpoller.enable = true;
      exporters.unpoller.controllers = [
        {
          url = "https://unifi.pwnyboy.com";
          user = "unpoller";
          pass = config.sops.secrets."unpoller-pass".path;
        }
      ];

      scrapeConfigs = [
        {
          job_name = "unifi";
          static_configs = [
            {
              targets = [
                ":9130"
              ];
            }
          ];
        }
      ];

      ruleFiles = [
        (pkgs.writeText "unifi-rules" # yaml
          ''
            groups:
              - name: Unifi
          '')
      ];
    };
  };
}
