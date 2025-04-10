{ config, pkgs, ... }: {
  services = {
    chrony.enable = true;
    fwupd.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = [
        "--ssh"
        "--webclient"
      ];
    };

    smartd.enable = true;
    prometheus.exporters = {
      node.enable = true;
      smartctl.enable = true;
    };

    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm.wayland = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
  ];

  gaming = {
    emulation.enable = true;
    steam.enable = true;
    wine.enable = true;
  };
}
