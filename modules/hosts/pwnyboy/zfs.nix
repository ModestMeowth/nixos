{ den, ... }:
{
  den.aspects.pwnyboy = {
    includes = [ den.aspects.filesystems._.zfs ];

    nixos = {
      fileSystems = {
        "/" = {
          device = "zroot/pwnyboy/root";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };

        "/nix" = {
          device = "zroot/pwnyboy/nix";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };

        "/persist/etc" = {
          device = "zroot/persist/etc";
          fsType = "zfs";
          options = [ "zfsutil" ];
          neededForBoot = true;
        };
      };

      boot.zfs.extraPools = [
        "docker"
        "persist"
      ];

      services.sanoid.datasets = {
        "zroot/persist/home/mm".use_template = [ "default" ];
        "zroot/persist/home/root".use_template = [ "default" ];

        "persist/backups/emulation/saves".use_template = [ "default" ];
        "persist/backups/signal".use_template = [ "default" ];
        "persist/cloud/photos".use_template = [ "default" ];
        "persist/data".use_template = [ "default" ];

        "docker/config".use_template = [ "default" ];
      };
    };
  };
}
