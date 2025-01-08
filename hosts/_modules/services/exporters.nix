{config, lib, pkgs, ...}: let
  cfg = config.wsl;
in {
  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = [
        "systemd"
      ];
      openFirewall = true;
    };

    smartctl = lib.mkIf (!cfg.enable) {
      enable = true;
      openFirewall = true;
    };
  };

  services.smartd.enable = (!cfg.enable);

  environment.systemPackages = lib.mkIf (!cfg.enable) (with pkgs; [
    pciutils
    smartmontools
  ]);
}
