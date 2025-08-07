{ config, pkgs, ... }: {
  services = {
    chrony.enable = true;
    fwupd.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [ "--ssh" "--webclient" "--accept-routes" ];
    };

    smartd.enable = true;

    fprintd = {
      enable = true;
      tod.enable = true;
      tod.driver = pkgs.libfprint-2-tod1-elan;
    };
  };

  environment.systemPackages = with pkgs; [ smartmontools samba ];

  gaming = {
    emulation.enable = true;
    ffxiv.enable = true;
    steam.enable = true;
  };

}
