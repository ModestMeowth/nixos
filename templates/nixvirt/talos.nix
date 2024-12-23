{ inputs, pkgs, ... }: {
  name,
  uuid,
  memory ? { count = 4; unit = "GiB"; },
  storage_vol ? null,
  nvram_path ? null,
  mac_address ? null,
  virtio_drive ? true,
  ...
}: let
  base = inputs.virt.lib.domain.templates.linux {
    virtio_video = true;
    install_vol = /persist/vm/iso/Talos-1.9.0.iso;
    inherit name uuid memory storage_vol virtio_drive;
  };
in base // {
  vcpu.count = 2;
  devices = base.devices // {
    interface.type = "network";
    interface.model.type = "virtio";
    interface.source.network = "default";
    interface.mac.address = mac_address;
  };
}
