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
        name = "talos3";
        uuid = "96be0a11-6364-45a7-b36d-8584889f8cfb";
        title = "Talos3";
        storage_vol.pool = "Disks";
        storage_vol.volume = "talos3.qcow2";
        nvram_path = "/persist/vm/nvram/talos3.fd";
        mac_address = "52:54:00:43:c9:c5";
        hostdev = {
          mode = "subsystem";
          type = "pci";
          managed = true;
          display = true;
          driver.name = "vfio";
          source.address.domain = 0;
          source.address.bus = 0;
          source.address.slot = 2;
          source.address.function = 3;
          address.type = "pci";
          address.bus = 4;
          address.slot = 0;
          address.function = 0;
        };
      });
    }
  ];
}
