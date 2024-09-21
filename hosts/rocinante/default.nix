{
  networking.hostName = "rocinante";

  imports = [
    ./hardware.nix
    ./secrets.nix
    ./users.nix
  ];

  hostConfig = {
    hw = {
      chassis = "laptop";
      cpu = "amd";
      gpu = "amd";

      secureboot = true;
      zfs = true;
    };

    secrets.sops = true;

    utils = {
      nm.enable = true;
      tailscale.enable = true;
      fwupd.enable = true;
    };

    wm.gnome.enable = true;

    cluster.k3s = true;
  };

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
