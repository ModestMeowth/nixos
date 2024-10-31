{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-worker-1";
      uuid = "2197db30-38ca-4d0a-9bb9-dc06c27d7914";
      title = "Talos-Worker-1";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-worker-1.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    } // {
      vcpu.count = 2;
    });
  }];
}
