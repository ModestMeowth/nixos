{ den, inputs, ... }:
  let
    sopsFile = inputs.self + /secrets/thoughtpolice.sops.yaml;
  in
{
  den.hosts.x86_64-linux.thoughtpolice = {
    users.mm = { };
  };

  den.aspects.thoughtpolice = {
      includes = with den.aspects; [
        profiles.workstation

        hw.gpu._.nvidia
        yubikey._.u2f

        desktop._.gaming
        desktop._.plasma

        apps._.ventoy

        virt._.docker
        printing.default
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
          fwupd.enable = true;
        };

        shares.pwnyboy-media = {
          enable = true;
          mountpoint = "/persist/media";
        };

        sops.secrets."tskey" = {
          mode = "0440";
          group = "wheel";
          sopsFile = sopsFile;
        };
      };
    };
}
