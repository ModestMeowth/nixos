{hostname, pkgs, ...}: {
  networking.hostName = hostname;

  imports = [
    ./hardware.nix
    ./secrets.nix
    ../../users/mm
  ];

  modules.monitoring = {
    node-exporter.enable = true;
    smartd.enable = true;
  };

  modules.services = {
    chrony.enable = true;
    ssh.enable = true;
    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
    };
  };

  modules.shares.pwnyboy-share = {
    enable = true;
    mountpoint = "/persist/share";
  };

  modules.cluster.k3s.enable = true;
  modules.wm.gnome.enable = true;

  services.fwupd.enable = true;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
}
