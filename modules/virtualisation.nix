{ ... }:
{
  den.aspects.virt._ = {
    qemu.nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.virglrenderer ];
        networking.firewall.trustedInterfaces = [ "virbr0" ];
        virtualisation = {
          libvirt.enable = true;
          spiceUSBRedirection.enable = true;
        };
      };

    waydroid.nixos = {
      virtualisation.waydroid.enable = true;
    };

    docker.nixos =
      { config, ... }:
      let
        nvidia = config.hardware.nvidia-container-toolkit;
      in
      {
        networking.firewall.trustedInterfaces = [ "docker0" ];
        virtualisation.docker = {
          enable = true;
          daemon.settings.features.cdi = nvidia.enable;
          autoPrune = {
            enable = true;
            flags = [ "--all" ];
          };
        };
      };

    podman.nixos = {
      networking.firewall.trustedInterfaces = [ "podman0" ];
      virtualisation.podman = {
        enable = true;
        autoPrune = {
          enable = true;
          flags = [ "--all" ];
        };
      };
    };

    incus.nixos =
      { lib, ... }:
      {
        networking.firewall.trustedInterfaces = [ "incusbr0" ];
        virtualisation.incus = {
          enable = true;
          ui.enable = lib.mkDefault true;
        };
      };

  };
}
