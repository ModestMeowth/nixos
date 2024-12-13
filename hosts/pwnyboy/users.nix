{
  imports = [ ../../users/mm ];

  fileSystems."home/mm" = {
    device = "zroot/persist/home/mm";
    fsType = "zfs";
  };
}
