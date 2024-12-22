{ config, pkgs, ... }: {
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKeyFile = config.sops.secrets."tskey".path;
    extraSetFlags = ["--ssh"];
  };

  services.prometheus.exporters.node.enable = true;
}
