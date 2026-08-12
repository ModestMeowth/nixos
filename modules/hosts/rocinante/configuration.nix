{ den, gaming, ... }:
{
  den.hosts.x86_64-linux.rocinante = {
    users.mm = { };
  };

  den.aspects.rocinante = {
    includes = with den.aspects; [
      profiles.laptop
      yubikey._.u2f

      desktop._.dms._.hyprland

      virt._.docker
      gaming.default
    ];

    nixos = {
      nixpkgs.config.rocmSupport = true;

      hardware = {
        facter.reportPath = ./facter.json;
        amdgpu.initrd.enable = true;
      };

      programs = {
        kdeconnect.enable = true;
        nix-ld.enable = true;
        wireshark = {
          enable = true;
          dumpcap.enable = true;
          usbmon.enable = true;
        };
      };

      services = {
        fwupd.enable = true;

        xserver.videoDrivers = [ "amdgpu" ];
      };

      shares.pwnyboy-media = {
        enable = true;
        mountpoint = "/persist/media";
      };
    };
  };
}
