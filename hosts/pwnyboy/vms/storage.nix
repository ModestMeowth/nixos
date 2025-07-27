{ inputs, ... }:
let
  virt = inputs.nix-virt;
  storagePath = "/persist/vm";
in {
  virtualisation.libvirt.connections."qemu:///system" = {
    pools = [
      {
        active = true;
        definition = virt.lib.pool.writeXML {
          name = "Disks";
          uuid = "8a0b38fe-f474-4a74-92d1-ae4e7a0c9703";
          type = "dir";
          target.path = "${storagePath}/disks";
        };
      }
      {
        active = true;
        definition = virt.lib.pool.writeXML {
          name = "ISO";
          uuid = "82f42fcb-d598-4a4c-b3e4-32ff4f59ea7c";
          type = "dir";
          target.path = "${storagePath}/iso";
        };
      }
      {
        active = true;
        definition = virt.lib.pool.writeXML {
          name = "NVRAM";
          uuid = "6005c1cb-c75a-47d8-b604-bc39bce85de9";
          type = "dir";
          target.path = "${storagePath}/nvram";
        };
      }
    ];
  };
}
