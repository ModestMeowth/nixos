{config, lib, pkgs, ...}: with lib; let
  cfg = config.modules.shares;
in {
  options.modules.shares = {
    pwnyboy-share = {
      enable = mkEnableOption "pwnyboy-share";
      mountpoint = mkOption {
        type = types.path;
        default = "/share";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.pwnyboy-share.enable {
      environment.systemPackages = [ pkgs.cifs-utils ];
      fileSystems."${cfg.pwnyboy-share.mountpoint}" = {
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
    })
  ];
}
