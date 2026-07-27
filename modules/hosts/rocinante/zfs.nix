{ den, ... }:
{
  den.aspects.rocinante = {
    includes = [ den.aspects.filesystems._.zfs ];

    nixos = {
      fileSystems = {
        "/" = {
          device = "zroot/rocinante/root";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };

        "/nix" = {
          device = "zroot/rocinante/nix";
          fsType = "zfs";
          options = [ "zfsutil" ];
        };

        "/persist/etc" = {
          device = "zroot/persist/etc";
          fsType = "zfs";
          neededForBoot = true;
          options = [ "zfsutil" ];
        };
      };

      services.sanoid.datasets = {
        "zroot/persist/home/mm".use_template = [ "default" ];
        "zroot/persist/home/root".use_template = [ "default" ];
      };
    };
  };
}
