{ lib, ... }:
{
  den.default.nixos =
    { config, lib, ... }:
    let
      inherit (lib) join;
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
        # sops.secrets."smb-pwnyboy".mode = "0400";
        # environment.systemPackages = [ pkgs.cifs-utils ];
        # fileSystems."${cfg.mountpoint}" = {
        #   fsType = "cifs";
        #   device = "//pwnyboy/media";
        #   options = [
        #     "credentials=/run/secrets/smb-pwnyboy"
        #     "dir_mode=0750"
        #     "file_mode=0640"
        #     "noauto"
        #     "uid=${toString config.users.users.mm.uid}"
        #     "gid=100"
        #     "x-systemd.after=tailscaled.service"
        #     "x-systemd.automount"
        #     "x-systemd.device-timeout=5s"
        #     "x-systemd.idle-timeout=60s"
        #     "x-systemd.mount-timeout=5s"
        #     "x-systemd.requires=sys-subsystem-net-devices-tailscale0.device"
        #   ];
        # };

        boot.supportedFilesystems.nfs = true;

        systemd.mounts = [{
          after = [ "tailscaled.service" ];
          requires = [ "sys-subsystem-net-devices-tailscale0.device" ];

          mountConfig = {
            Options = join "," [
              "noauto"
            ];
          };

          type = "nfs";

          what = "192.168.1.30:/persist/data/media";
          where = cfg.mountpoint;
        }];

        systemd.automounts = [{
          automountConfig.TimeoutIdleSec = "60s";
          wantedBy = [ "multi-user.target" ];
          where = cfg.mountpoint;
        }];
      };
    };
}
