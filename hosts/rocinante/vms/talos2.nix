{ inputs, ... }:
let
  virt = inputs.virt;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (
      let
        base = virt.lib.domain.templates.linux {
          name = "talos2";
          uuid = "a9aed73e-5402-4a48-acc3-72ade8f28510";
          title = "Talos2";
          storage_vol.pool = "Disks";
          storage_vol.volume = "talos2.qcow2";
          install_vol = /persist/vm/iso/Talos-1.8.3.iso;
        };
      in
      base // {
        vcpu.count = 2;
        devices = base.devices // {
          interfaces.mac.address = "52:54:00:4a:a2:73";
        };
      }
    );
    active = true;
  }];
}
