{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-worker-2";
      uuid = "a8ce0f3e-1c26-4b15-a2d7-64294c03b671";
      title = "Talos-Worker-2";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-worker-2.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    } // {
      vcpu.count = 1;
    });
  }];
}
