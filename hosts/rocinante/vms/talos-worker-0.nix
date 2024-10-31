{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (virt.lib.domain.templates.linux {
      name = "talos-worker-0";
      uuid = "14b82998-c4ee-4827-96b4-8ea989d52f7b";
      title = "Talos-Worker-0";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos-worker-0.qcow2";
      install_vol = /persist/vm/iso/Talos-1.8.2.iso;
      } // {
        vcpu.count = 2;
      });
  }];
}
