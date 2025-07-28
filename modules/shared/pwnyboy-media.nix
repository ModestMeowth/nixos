{ config, lib, pkgs, ... }:
let cfg = config.shares.pwnyboy-media;
in {
  options.shares.pwnyboy-media = {
    enable = lib.mkEnableOption "pwnyboy-media";

    mountpoint = lib.mkOption {
      type = lib.types.path;
      default = "/media";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."smb-pwnyboy".mode = "0400";

    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems."${cfg.mountpoint}" = {
      fsType = "cifs";
      device = "//pwnyboy/media";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd-idle-timeout=60s"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
        "x-systemd.requires=sys-subsystem-net-devices-tailscale0.device"
        "x-systemd.after=tailscaled.service"
        "dir_mode=0750"
        "file_mode=0640"
        "uid=1001"
        "gid=100"
        "credentials=/run/secrets/smb-pwnyboy"
      ];
    };
  };
}
