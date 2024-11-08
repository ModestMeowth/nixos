{inputs, ...}: let
  virt = inputs.virt;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (let
      base = virt.lib.domain.templates.linux {
        name = "talos0";
        uuid = "5667324a-1b6a-407f-b5ae-2e76280b16a0";
        title = "Talos0";
        storage_vol.pool = "Disks";
        storage_vol.volume = "talos0.qcow2";
        install_vol = /persist/vm/iso/Talos-1.8.2.iso;
    };
    in base // {
      vcpu.count = 2;
      devices = base.devices // {
        interfaces.mac.address = "52:54:00:1b:13:05";
      };
    });
    active = true;
  }];
}
