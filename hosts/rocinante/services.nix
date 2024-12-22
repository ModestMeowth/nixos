{ config, pkgs, ... }: {
  services.chrony.enable = true;
  services.fwupd.enable = true;

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKeyFile = config.sops.secrets."tskey".path;
    extraSetFlags = ["--ssh"];
  };

  services.smartd.enable = true;
  environment.systemPackages = [ pkgs.smartmontools ];
  services.prometheus.exporters = {
    node.enable = true;
    smartctl.enable = true;
  };

  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  programs.gamemode.enable = true;
}
