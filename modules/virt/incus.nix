{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.virt.incus = {
    nixos =
      {
        networking.firewall.trustedInterfaces = [ "incusbr0" ];
        virtualisation.incus = {
          enable = true;
          ui.enable = mkDefault true;
        };
      };
  };
}
