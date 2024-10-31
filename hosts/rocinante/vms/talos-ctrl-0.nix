{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-ctrl-0";
      uuid = "5667324a-1b6a-407f-b5ae-2e76280b16a0";
      title = "Talos-Control-Plane-0";
      memory.count = 2;
      memory.unit = "GiB";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-ctrl-0.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    } // {
      vcpu.count = 2;
    });
  }];
}
