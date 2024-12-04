stuff@{inputs, pkgs, ...}:
let
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos.nix;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (import template stuff {
      name = "talos3";
      uuid = "9ecdef2c-0e5d-4e9a-b785-a71e1112eb40";
      title = "Talos3";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos3.qcow2";
      mac_address = "52:54:00:43:c9:c5";
    });
    active = true;
  }];
}
