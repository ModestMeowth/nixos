{ lib, ... }:
{
  den.aspects.filesystems = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.smartmontools ];

        services.smartd.enable = lib.mkDefault true;
      };
    _.ntfs.nixos = {
      boot.supportedFilesystems = [ "ntfs" ];
    };

    _.zfs.nixos =
      { pkgs, ... }:
      {
        boot = {
          supportedFilesystems.zfs = true;
          zfs.forceImportRoot = false;
        };

        environment.systemPackages = [ pkgs.sanoid ];

        services = {
          lvm.enable = lib.mkDefault false;

          sanoid = {
            enable = true;
            templates.default = {
              autoprune = true;
              autosnap = true;
              hourly = 24;
              daily = 30;
              monthly = 12;
            };
          };

          zfs = {
            autoScrub = {
              enable = true;
              interval = "Sun, 2:00:00";
              randomizedDelaySec = "3h";
            };
            trim.enable = true;
          };
        };
      };
  };
}
