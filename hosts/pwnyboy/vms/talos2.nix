stuff@{ inputs, pkgs, ... }:
let
  virt = inputs.virt;
  template = ../../../templates/nixvirt/talos-sb.nix;
in
{
  virtualisation.libvirt.connections."qemu:///system".domains = [
    {
      active = true;
      definition = virt.lib.domain.writeXML (import template stuff {
        name = "talos2";
        uuid = "f6f638b1-64db-4558-9f2e-f4da37fc0213";
        title = "Talos2";
        storage_vol.pool = "Disks";
        storage_vol.volume = "talos2.qcow2";
        nvram_path = "/persist/vm/nvram/talos2.fd";
        mac_address = "52:54:00:4a:a2:73";
        hostdev = {
          mode = "subsystem";
          type = "pci";
          managed = true;
          display = true;
          driver.name = "vfio";
          source.address.domain = 0;
          source.address.bus = 0;
          source.address.slot = 2;
          source.address.function = 2;
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
