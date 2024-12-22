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
    options = [
      "dmask=0077"
      "fmask=0177"
    ];
  };

  shares.pwnyboy-media = {
    enable = true;
    mountpoint = "/persist/media";
  };

  services.sanoid = {
    datasets."${persist}/home/mm" = {
      useTemplate = [ "default" ];
    };
  };
}
