{lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.virt.qemu = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.virglrenderer ];
        networking.firewall.trustedInterfaces = [ "virbr0" ];
        virtualisation = {
          libvirt.enable = mkDefault true;
          spiceUSBRedirection.enable = mkDefault true;
        };
      };
  };
}
