{ config, pkgs, ... }: {
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    #    authKeyFile = config.sops.secrets."tskey".path;
  };

  services.openssh.enable = true;
  services.prometheus.exporters.node.enable = true;

  shares.pwnyboy-share.enable = true;
}
