{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.fleet.useZfs;
in
{
  options.fleet.useZfs = lib.mkEnableOption "device uses ZFS";

  config = lib.mkIf cfg {
    boot = {
      supportedFilesystems.zfs = true;
      zfs.forceImportRoot = false;
    };

    environment.systemPackages = with pkgs; [
      pciutils
      smartmontools
      (writeShellScriptBin "sanoid" ''
        ${config.systemd.services.sanoid.serviceConfig.ExecStart} $@
      '')
    ];

    networking.hostId = "00bab10c"; # Allows ZFSBootMenu to work if necessary

    services = {
      lvm.enable = lib.mkDefault false;

      sanoid = {
        enable = true;
        templates.default = {
          autoprune = true;
          autosnap = true;
          hourly = 24;
          daily = 30;
          monthly = 12;
        };
      };

      smartd.enable = true;

      zfs.autoScrub = {
        enable = true;
        interval = "Sun, 2:00:00";
        randomizedDelaySec = "3h";
      };
      zfs.trim.enable = true;
    };
  };
}
