{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-ctrl-2";
      uuid = "9ecdef2c-0e5d-4e9a-b785-a71e1112eb40";
      title = "Talos-Control-Plane-2";
      memory.count = 2;
      memory.unit = "GiB";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-ctrl-2.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    } // {
      vcpu.count = 2;
    });
  }];
}
