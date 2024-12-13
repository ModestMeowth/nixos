let
  root = "zroot/rocinante";
  persist = "zroot/persist";
in
{
  fileSystems."/" = {
    device = "${root}/root";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7785953DEF-part1";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "${root}/nix";
    fsType = "zfs";
  };

  fileSystems."/root" = {
    device = "${persist}/home/root";
    fsType = "zfs";
  };

  fileSystems."/persist/vm/disk" = {
    device = "${persist}/vm/disk";
    fsType = "zfs";
  };

  fileSystems."/persist/vm/iso" = {
    device = "${persist}/vm/iso";
    fsType = "zfs";
  };

  fileSystems."/persist/vm/nvram" = {
    device = "${persist}/vm/nvram";
    fsType = "zfs";
  };

  services.sanoid = {
    datasets."${persist}/home/mm" = {
      useTemplate = [ "default" ];
    };
  };
}
