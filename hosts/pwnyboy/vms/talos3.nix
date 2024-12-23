stuff@{inputs, pkgs, ...}: let
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos-sb.nix;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = [
    {
      active = true;
      definition = virt.lib.domain.writeXML(import template stuff {
        name = "talos3";
        uuid = "96be0a11-6364-45a7-b36d-8584889f8cfb";
        title = "Talos3";
        storage_vol.pool = "Disks";
        storage_vol.volume = "talos3.qcow2";
        nvram_path = "/persist/vm/nvram/talos3.fd";
        mac_address = "52:54:00:1b:13:05";
      });
    }
  ];
}
