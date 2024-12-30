{ config, pkgs, ... }: {
  services = {
    chrony.enable = true;
    fwupd.enable = true;

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      authKeyFile = config.sops.secrets."tskey".path;
      extraSetFlags = ["--ssh"];
    };

    smartd.enable = true;
    prometheus.exporters = {
      node.enable = true;
      smartctl.enable = true;
    };

    xserver.desktopManager.gnome.enable = true;
    xserver.displayManager.gdm.wayland = true;
  };

  programs = {
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
  ];
}
