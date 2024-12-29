{ config, pkgs, ... }: {
  services = {
    chrony.enable = true;

    tailscale.enable = true;
    tailscale.package = pkgs.unstable.tailscale;
    tailscale.authKeyFile = config.sops.secrets."tskey".path;
    tailscale.extraSetFlags = ["--ssh"];

    prometheus.exporters = {
      node.enable = true;
      smartctl.enable = true;
    };

    fwupd.enable = true;

    nix-serve.enable = true;
    nix-serve.secretKeyFile = config.sops.secrets."cache-priv-key".path;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    docker-compose
  ];

  virtualisation.docker.enable = true;
}
