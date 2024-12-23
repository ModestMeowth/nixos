{ inputs, pkgs, ... }: {
  name,
  uuid,
  memory ? { count = 4; unit = "GiB"; },
  storage_vol ? null,
  nvram_path ? null,
  mac_address ? null,
  virtio_drive ? true,
  hostdev ? null,
  ...
}: let
  base = inputs.virt.lib.domain.templates.linux {
    virtio_video = true;
    install_vol = /persist/vm/iso/Talos-1.9.0.iso;
    inherit name uuid memory storage_vol virtio_drive;
  };
in base // {
  vcpu.count = 2;
  os = base.os // {
      loader.readonly = true;
      loader.type = "pflash";
      loader.path = "${pkgs.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
      nvram.template = "${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd";
      nvram.path = nvram_path;
  };

  devices = base.devices // {
    interface.type = "bridge";
    interface.model.type = "virtio";
    interface.source.bridge = "bridge0";
    interface.mac.address = mac_address;

    # allow remote graphical console
    graphics.type = "spice";
    graphics.autoport = true;
    graphics.listen.type = "address";
    graphics.listen.address = "0.0.0.0";

    # Spice GL doesn't support remote connections
    graphics.gl.enable = false;
    video.model.type = "virtio";
    video.acceleration.accel3d = false;

    tpm.model = "tpm-crb";
    tpm.backend.type = "emulator";
    tpm.backend.version = "2.0";

    hostdev = hostdev;
  };
}
