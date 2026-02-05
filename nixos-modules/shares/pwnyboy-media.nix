{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.shares.pwnyboy-media;
  hostname = config.networking.hostName;
in
{
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
        "credentials=/run/secrets/smb-pwnyboy"
        "dir_mode=0750"
        "file_mode=0640"
        "noauto"
        "uid=${toString config.users.users."mm-${hostname}".uid}"
        "gid=100"
        "x-systemd.after=tailscaled.service"
        "x-systemd.automount"
        "x-systemd.device-timeout=5s"
        "x-systemd.idle-timeout=60s"
        "x-systemd.mount-timeout=5s"
        "x-systemd.requires=sys-subsystem-net-devices-tailscale0.device"
      ];
    };
  };
}
