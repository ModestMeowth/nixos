{inputs, ...}: let
  virt = inputs.virt;
  storagePath = "/persist/vm";
in
{
  virtualisation.libvirt.connections."qemu:///system" = {

    pools = [
      {
        definition = virt.lib.pool.writeXML {
          name = "Disks";
          uuid = "a42a8dd4-0d03-40c4-8650-c38757916f1d";
          type = "dir";
          target = { path = "${storagePath}/disk"; };
        };
        active = true;
      }
      {
        definition = virt.lib.pool.writeXML {
          name = "ISO";
          uuid = "4f182cce-d6e8-4880-a39c-bd59dc7a48a3";
          type = "dir";
          target = { path = "${storagePath}/iso"; };
        };
        active = true;
      }
    ];
  };
}
