{ config, lib, pkgs, ... }:
let
  cfg = config.shares.ha-config;
in
{
  options.shares.ha-config = {
    enable = lib.mkEnableOption "homeassistant-config";

    mountpoint = lib.mkOption {
      type = lib.types.path;
      default = "/persist/ha-config";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."smb-ha".mode = "0400";

    environment.systemPackages = [ pkgs.cifs-utils ];

    fileSystems."${cfg.mountpoint}" = {
      fsType = "cifs";
      device = "//homeassistant/config";
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
        "credentials=/run/secrets/smb-ha"
      ];
    };
  };
}
