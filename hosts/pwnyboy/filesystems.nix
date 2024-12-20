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

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-INTEL_SSDPEDMW400G4_CVCQ5252008B400AGN-part1";
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "${root}/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  services.sanoid.datasets."${persist}".useTemplate = [ "default" ];
}
