{ inputs, ... }:
{
  den.aspects.microvm._.host.nixos = {
    imports = [ inputs.microvm.nixosModules.host ];

    systemd.network.networks."10-microvms" = {
      matchConfig.Name = "tap0";
      address = [ "10.4.4.1/30" ];
      networking.IPv4Forwarding = true;
    };

    networking.nftables.ruleset = ''
      table ip nat {
        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
          ip saddr 10.4.4.0/30 masquerade
        }
      }
    '';
  };
}
