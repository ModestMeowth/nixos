{config, lib, pkgs, ...}: let
  cfg = config.wsl;
in {
  services.prometheus.exporters = {
    node.enable = true;
    node.enabledCollectors = [
      "systemd"
    ];

    smartctl.enable = (!cfg.enable);
  };

  services.smartd.enable = (!cfg.enable);

  environment.systemPackages = lib.mkIf (!cfg.enable) (with pkgs; [
    pciutils
    smartmontools
  ]);
}
