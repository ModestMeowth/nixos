{inputs, ...}: let
  virt = inputs.virt;
  cidr = "192.168.100";
  mac = "52:54:00";
in
{
  networking.firewall = {
    trustedInterfaces = ["virbr+"];

    extraForwardRules = ''
      iifname virbr+ accept
    '';
  };

  virtualisation.libvirt.connections."qemu:///system" = {

    networks = [
      {
        definition = virt.lib.network.writeXML {
            name = "default";
            uuid = "83c1e2a9-65ae-4b5f-8e33-9dfca84c0a95";

            forward.mode = "nat";
            bridge.name = "virbr0";

            ip.address = "${cidr}.1";
            ip.prefix = 24;

            ip.dhcp.range.start = "${cidr}.101";
            ip.dhcp.range.end = "${cidr}.254";

            ip.dhcp.host = [
              {
                name = "talos1";
                ip = "${cidr}.101";
                mac = "${mac}:1b:13:05";
              }
              {
                name = "talos2";
                ip = "${cidr}.102";
                mac = "${mac}:4a:a2:73";
              }
              {
                name = "talos3";
                ip = "${cidr}.103";
                mac = "${mac}:43:c9:c5";
              }
            ];
          };
        active = true;
      }
    ];
  };
}
