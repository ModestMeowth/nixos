{ config, pkgs, ... }: {
  modules.services.ssh.enable = true;
  modules.services.chrony.enable = true;

  services.fwupd.enable = true;
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKeyFile = config.sops.secrets."tskey".path;
  };

  services.prometheus.exporters = {
    node.enable = true;
    smartctl.enable = true;
  };

  environment.systemPackages = [ pkgs.smartmontools ];
}
