let
  root = "zroot/pwnyboy";
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
    device = "/dev/disk/by-id/nvme-INTEL_SSDPEDMW400G4_CVCQ5252008B400AGN-part1";
    fsType = "vfat";
    options = [
      "dmask=0077"
      "fmask=0177"
    ];
  };

  services.sanoid.datasets."${persist}".useTemplate = [ "default" ];
}
