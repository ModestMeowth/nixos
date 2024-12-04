stuff@{inputs, pkgs, ...}:
let
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos.nix;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (import template stuff {
      name = "talos2";
      uuid = "a9aed73e-5402-4a48-acc3-72ade8f28510";
      title = "Talos2";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos2.qcow2";
      mac_address = "52:54:00:4a:a2:73";
    });
    active = true;
  }];
}
