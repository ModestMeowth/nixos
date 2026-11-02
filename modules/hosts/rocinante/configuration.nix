{ den, ... }:
{
  den.hosts.x86_64-linux.rocinante = {
    users.mm = { };
  };

  den.aspects.rocinante = {
    includes = with den.aspects; [
      profiles.laptop
      hw.gpu._.amd

      yubikey._.u2f

      desktop._.gaming
      desktop._.plasma

      virt._.docker
      printing.default

      apps._.ventoy
    ];

    nixos = {
      hardware = {
        facter.reportPath = ./facter.json;
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
