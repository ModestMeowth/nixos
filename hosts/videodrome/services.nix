{ config, pkgs, ... }: {
  services = {
    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [
        "--ssh"
        "--webclient"
      ];
    };

    prometheus.exporters.node.enable = true;
  };

  programs = {
    dconf.enable = true;
  };
}
