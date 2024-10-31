{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-ctrl-1";
      uuid = "a9aed73e-5402-4a48-acc3-72ade8f28510";
      title = "Talos-Control-Plane-1";
      memory.count = 2;
      memory.unit = "GiB";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-ctrl-1.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    } // {
      vcpu.count = 2;
    });
  }];
}
