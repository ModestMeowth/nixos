{ den, ... }:
{
  den.aspects.thoughtpolice = {
    includes = [ den.aspects.filesystems._.zfs ];

    nixos = {
      fileSystems."/" = {
        device = "zroot/thoughtpolice/root";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/nix" = {
        device = "zroot/thoughtpolice/nix";
        fsType = "zfs";
        options = [ "zfsutil" ];
      };

      fileSystems."/persist/etc" = {
        device = "zroot/persist/etc";
        fsType = "zfs";
        neededForBoot = true;
        options = [ "zfsutil" ];
      };

      services.sanoid.datasets = {
        "zroot/persist/home/mm".use_template = [ "default" ];
        "zroot/persist/home/root".use_template = [ "default" ];
      };
    };
  };
}
