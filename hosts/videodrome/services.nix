{ config, pkgs, ... }: {
  services = {
    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [ "--ssh" "--webclient" "--accept-routes" ];
    };
  };

  programs = { dconf.enable = true; };
}
