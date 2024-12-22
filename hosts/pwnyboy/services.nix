{ config, pkgs, ... }: {
  services.chrony.enable = true;

  services.fwupd.enable = true;
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKeyFile = config.sops.secrets."tskey".path;
    extraSetFlags = ["--ssh"];
  };

  services.prometheus.exporters = {
    node.enable = true;
    smartctl.enable = true;
  };

  environment.systemPackages = [ pkgs.smartmontools ];
}
