stuff@{inputs, pkgs, ...}: let
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos.nix;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [{
    definition = virt.lib.domain.writeXML (import template stuff {
      name = "talos1";
      uuid = "5667324a-1b6a-407f-b5ae-2e76280b16a0";
      title = "Talos1";
      storage_vol.pool = "Disks";
      storage_vol.volume = "talos1.qcow2";
      mac_address = "52:54:00:1b:13:05";
    });
    active = true;
  }];
}
