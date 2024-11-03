{inputs, ...}: let
  virt = inputs.virt;

in {
  imports = [
    ./talos0.nix
    ./talos1.nix
    ./talos2.nix
  ];

  networking.firewall.trustedInterfaces= ["virbr0"];

  virtualisation.libvirt.connections."qemu:///system" = {
    networks = [
      {
        definition = let
          cidr = "192.168.1";
          mac = "52:54:00";
        in virt.lib.network.writeXML {
          name = "default";
          uuid = "83c1e2a9-65ae-4b5f-8e33-9dfca84c0a95";

          forward.mode = "nat";
          forward.nat.port.start = 1024;
          forward.nat.port.end = 65535;

          bridge.name = "virbr0";

          ip.address = "${cidr}.1";
          ip.prefix = 24;

          ip.dhcp.range.start = "${cidr}.101";
          ip.dhcp.range.end = "${cidr}.254";

          ip.dhcp.host = [
            {
              name = "talos0";
              ip = "${cidr}.2";
              mac = "${mac}:1b:13:05";
            }
            {
              name = "talos1";
              ip = "${cidr}.3";
              mac = "${mac}:4a:a2:73";
            }
            {
              name = "talos2";
              ip = "${cidr}.4";
              mac = "${mac}:43:c9:c5";
            }
          ];
        };
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
