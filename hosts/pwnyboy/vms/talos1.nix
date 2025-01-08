stuff@{ config, lib, inputs, pkgs, ... }:
let
  cfg = config.virtualisation.libvirtd;
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos-sb.nix;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = lib.mkIf cfg.enable [
    {
      active = true;
      definition = virt.lib.domain.writeXML (import template stuff {
        name = "talos1";
        uuid = "07437c22-939f-4994-b2dc-aacd91d3d7e1";
        title = "Talos1";
        storage_vol.pool = "Disks";
        storage_vol.volume = "talos1.qcow2";
        nvram_path = "/persist/vm/nvram/talos1.fd";
        mac_address = "52:54:00:1b:13:05";
        hostdev = {
          mode = "subsystem";
          type = "pci";
          managed = true;
          display = true;
          driver.name = "vfio";
          source.address.domain = 0;
          source.address.bus = 0;
          source.address.slot = 2;
          source.address.function = 1;
          address.type = "pci";
          address.domain = 0;
          address.bus = 4;
          address.slot = 0;
          address.function = 0;
        };
      });
    }
  ];
}
