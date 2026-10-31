{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.virt._.podman = {
    nixos = {
      networking.firewall.trustedInterfaces = [ "podman0" ];
      virtualisation.podman = {
        enable = true;
        autoPrune = {
          enable = mkDefault true;
          flags = mkDefault [ "--all" ];
        };
      };
    };
  };
}
