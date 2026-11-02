{ den, ... }:
{
  den.hosts.x86_64-linux.rocinante = {
    users.mm = { };
  };

  den.aspects.rocinante = {
    includes = with den.aspects; [
      profile.laptop
      hw.gpu.amd
      hw.yubikey.u2f
      wm.plasma

      desktop.gaming
      apps.ventoy
      svc.printing
      virt.docker
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
        xserver.videoDrivers = [ "amdgpu" ];
      };

      shares.pwnyboy-media = {
        enable = true;
        mountpoint = "/persist/media";
      };

      users.users.mm.extraGroups = [
        "gamemode"
        "lp"
        "scanner"
        "wireshark"
      ];
    };
  };
}
