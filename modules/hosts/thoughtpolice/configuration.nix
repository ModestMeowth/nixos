{ den, gaming, ... }:
{
  den.hosts.x86_64-linux.thoughtpolice = {
    users.mm = { };
  };

  den.aspects.thoughtpolice = {
    includes = with den.aspects; [
      profiles.workstation

      nvidia
      yubikey._.u2f

      desktop._.dms._.hyprland

      virt._.docker
      gaming.default
      printing.default
    ];

    nixos = {
      nixpkgs.config.cudaSupport = true;

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
        fwupd.enable = true;
      };

      shares.pwnyboy-media = {
        enable = true;
        mountpoint = "/persist/media";
      };
    };
  };
}
