{ config, lib, pkgs, ... }:
let
  cfg = config.shares.pwnyboy-share;
in
{
  options.shares.pwnyboy-share = {
    enable = lib.mkEnableOption "pwnyboy-share";

    mountpoint = lib.mkOption {
      type = lib.types.path;
      default = "/share";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."smb-pwnyboy".mode = "0400";
    environment.systemPackages = [ pkgs.cifs-utils ];
    fileSystems."${cfg.mountpoint}" = {
      fsType = "cifs";
      device = "//pwnyboy/share";
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
