{ den, ... }:
{
  den.hosts.x86_64-linux.thoughtpolice = {
    users.mm = { };
  };

  den.aspects.thoughtpolice = {
      includes = with den.aspects; [
        profile.workstation
        hw.gpu.nvidia
        hw.yubikey.u2f
        wm.plasma

        desktop.gaming
        apps.ventoy
        svc.printing
        virt.docker
      ];

      nixos = {
        hardware = {
          facter = {
            enable = true;
            reportPath = ./facter.json;
          };
        };

        boot = {
          kernelParams = [ "video=efifb:3440x1440-bgr" ];
          plymouth.extraConfig = "DeviceScale=1";
          kernelModules = [ "sg" ];
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
          kmscon.config = {
            mode = "[DP-1]3440x1440@75";
          };
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
