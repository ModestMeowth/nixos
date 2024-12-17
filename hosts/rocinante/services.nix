{ config, pkgs, ... }: {
  modules.services.chrony.enable = true;
  modules.services.ssh.enable = true;
  services.fwupd.enable = true;

  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKeyFile = config.sops.secrets."tskey".path;
  };

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  services.smartd.enable = true;
  environment.systemPackages = [ pkgs.smartmontools ];
  services.prometheus.exporters = {
    node.enable = true;
    smartctl.enable = true;
  };

  modules.wm.gnome.enable = true;
  programs.gamemode.enable = true;
}
