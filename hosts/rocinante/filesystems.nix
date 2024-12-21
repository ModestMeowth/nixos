let
  root = "zroot/rocinante";
  persist = "zroot/persist";
in
{
  fileSystems."/" = {
    device = "${root}/root";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/nix" = {
    device = "${root}/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-KINGSTON_SNV2S1000G_50026B7785953DEF-part1";
    fsType = "vfat";
  };

  shares.pwnyboy-share = {
    enable = true;
    mountpoint = "/persist/share";
  };

  services.sanoid = {
    datasets."${persist}/home/mm" = {
      useTemplate = [ "default" ];
    };
  };
}
