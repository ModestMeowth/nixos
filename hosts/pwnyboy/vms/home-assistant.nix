stuff @ {config, lib, inputs, pkgs, ...}:
let
  cfg = config.virtualisation.libvirt;
  virt = inputs.virt;
  template = ../../../templates/nixvirt/home-assistant.nix;
in {
  virtualisation.libvirt.connections."qemu:///system".domains = lib.mkIf cfg.enable [
    {
      active = true;
      definition = virt.lib.domain.writeXML (import template stuff {
        name = "home-assistant";
        uuid = "88cd91e8-0153-4873-8a3a-033f513e6817";
        title = "HomeAssistant";
        storage_vol.pool = "Disks";
        storage_vol.volume = "home-assistant.qcow2";
        nvram_path = "/persist/vm/nvram/home-assistant.fd";
        mac_address = "52:54:00:72:24:39";
        hostdev = {
          mode = "subsystem";
          type = "usb";
          managed = true;
          source.vendor.id = 4292; # 0x10c4
          source.product.id = 60000; # ea60
          source.address.bus = 1;
          source.address.device = 3;
          alias.name = "hostdev0"
          address.type = "usb";
          address.bus = 0;
          address.port = 1;
        };
      });
    }
  ];
}
