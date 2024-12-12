{
  imports = [../../users/mm.nix];

  fileSystems."home/mm" = {
    device = "zroot/persist/home/mm";
    fsType = "zfs";
  };
}
