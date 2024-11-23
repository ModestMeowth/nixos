{ inputs, ... }:
let
  virt = inputs.virt;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (
      let
        base = virt.lib.domain.templates.linux {
          name = "talos3";
          uuid = "9ecdef2c-0e5d-4e9a-b785-a71e1112eb40";
          title = "Talos3";
          storage_vol.pool = "Disks";
          storage_vol.volume = "talos3.qcow2";
          install_vol = /persist/vm/iso/Talos-1.8.3.iso;
        };
      in
      base // {
        vcpu.count = 2;
        devices = base.devices // {
          interfaces.mac.address = "52:54:00:43:c9:c5";
        };
      }
    );
    active = true;
  }];
}
