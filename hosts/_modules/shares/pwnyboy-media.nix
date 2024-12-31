{ config, lib, pkgs, ... }:
let
  cfg = config.shares.pwnyboy-media;
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
        "noauto"
        "x-systemd.automount"
        "x-system.mount-timeout=5s"
        "dir_mode=0750"
        "file_mode=0640"
        "uid=1001"
        "gid=100"
        "credentials=/run/secrets/smb-pwnyboy"
      ];
    };
  };
}
