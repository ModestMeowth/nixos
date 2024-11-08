{
  fileSystems = {
    "/" = {
      device = "zroot/rocinante/root";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7785953DEF-part1";
      fsType = "vfat";
      options = [
        "defaults"
      ];
    };

    "/nix" = {
      device = "zroot/rocinante/nix";
      fsType = "zfs";
    };

    "/home/mm" = {
      device = "zroot/persist/home/mm";
      fsType = "zfs";
    };

    "/root" = {
      device = "zroot/persist/home/root";
      fsType = "zfs";
    };

    "/persist/vm/disk" = {
      device = "zroot/persist/vm/disk";
      fsType = "zfs";
    };

    "/persist/vm/iso" = {
      device = "zroot/persist/vm/iso";
      fsType = "zfs";
    };

    "/persist/vm/nvram" = {
      device = "zroot/persist/vm/nvram";
      fsType = "zfs";
    };
  };

  services.sanoid = {
    datasets."zroot/persist/home/mm" = {
      useTemplate = ["default"];
    };
  };
}
