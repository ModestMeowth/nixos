{inputs, ...}: let
  virt = inputs.virt;
in {
  imports = [
    ./talos-ctrl-0.nix
    ./talos-ctrl-1.nix
    ./talos-ctrl-2.nix
    ./talos-worker-0.nix
    ./talos-worker-1.nix
    ./talos-worker-2.nix
  ];

  networking.firewall.trustedInterfaces= ["virbr0"];

  virtualisation.libvirt.connections."qemu:///system" = {
    networks = [
      {
        definition = virt.lib.network.writeXML (virt.lib.network.templates.bridge {
          uuid = "83c1e2a9-65ae-4b5f-8e33-9dfca84c0a95";
          bridge_name = "virbr0";
          subnet_byte = 1;
        });
        active = true;
      }
    ];

    pools = [
      {
        definition = virt.lib.pool.writeXML {
          name = "Disks";
          uuid = "a42a8dd4-0d03-40c4-8650-c38757916f1d";
          type = "dir";
          target = {path = "/persist/vm/disk";};
        };
        active = true;
      }
      {
        definition = virt.lib.pool.writeXML {
          name = "ISO";
          uuid = "4f182cce-d6e8-4880-a39c-bd59dc7a48a3";
          type = "dir";
          target = {path = "/persist/vm/iso";};
        };
        active = true;
      }
    ];
  };
}
