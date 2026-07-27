{ den, ... }:
{
  den.aspects.boot = {
    _.secure = {
      includes = [ den.aspects.boot ];

      nixos = {
        boot.loader.limine.secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys.enable = true;
        };
      };
    };

    _.graphical = {
      includes = [ den.aspects.boot ];
      nixos = {
        boot = {
          plymouth.enable = true;
          consoleLogLevel = 3;
          initrd.verbose = false;
          kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
          ];
        };
      };
    };

    nixos =
      { lib, pkgs, ... }:
      {
        boot.loader = {
          efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
          };

          grub.enable = lib.mkForce false;
          systemd-boot.enable = lib.mkForce false;

          limine = {
            enable = true;
          };
        };

        environment.systemPackages = [ pkgs.sbctl ];
      };
  };
}
