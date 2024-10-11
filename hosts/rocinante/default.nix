{hostname, pkgs, ...}: {
  networking.hostName = hostname;

  imports = [
    ./hardware.nix
    ./secrets.nix
    ../../users/mm
  ];

  modules.monitoring.node-exporter.enable = true;
  modules.monitoring.smartd.enable = true;

  modules.services.chrony.enable = true;

  modules.services.ssh.enable = true;

  modules.services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  modules.cluster.k3s.enable = true;

  modules.wm.gnome.enable = true;

  services.fwupd.enable = true;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  modules.shares.pwnyboy-share = {
    enable = true;
    mountpoint = "/persist/share";
  };
}
