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
      nixos =
        {pkgs, ...}:
        {
          boot = {
            plymouth = {
              enable = true;
              theme = "catppuccin-mocha";
              themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
            };

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

          stylix.targets.plymouth.enable = false;
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
            maxGenerations = 5;
            style.wallpapers = [ ];
          };
        };

        environment.systemPackages = [ pkgs.sbctl ];
      };
  };
}
