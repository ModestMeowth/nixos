{lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.virt.docker = {
    nixos =
      { config, ... }:
      let
        nvidia = config.hardware.nvidia-container-toolkit;
      in
      {
        networking.firewall.trustedInterfaces = [ "docker0" ];
        virtualisation.docker = {
          enable = true;
          daemon.settings.features.cdi = mkDefault nvidia.enable;
          autoPrune = {
            enable = mkDefault true;
            flags = mkDefault [ "--all" ];
          };
        };
      };
  };
}
