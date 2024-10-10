{hostname, pkgs, ...}: {
  networking.hostName = hostname;

  imports = [
    ./hardware.nix
    ./secrets.nix
    ../../users/mm
  ];

  modules = {
    hw = {
      cpu = "amd";
      gpu.amd.enable = true;
      secureboot.enable = true;
      zfs.enable = true;
    };

    monitoring = {
      node-exporter.enable = true;
      smartd.enable = true;
    };

    services = {
      chrony.enable = true;
      ssh.enable = true;
      tailscale = {
        enable = true;
        package = pkgs.unstable.tailscale;
      };
    };

    cluster.k3s.enable = true;
    wm.gnome.enable = true;
  };

  services.fwupd.enable = true;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  fileSystems."/persist/share" = {
    fsType = "cifs";
    device = "//pwnyboy/share";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=5s"
      "dir_mode=0750"
      "file_mode=0640"
      "uid=1001"
      "gid=100"
      "credentials=/run/secrets/smb-pwnyboy"
    ];
  };
}
