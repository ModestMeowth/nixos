{ den, ... }:
{
  den.aspects.thoughtpolice = {
    includes = with den.aspects; [
      boot._.secure
      boot._.graphical
      kmscon
    ];

    nixos = {
      boot.loader.limine.resolution = "3440x1440x32";

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/3B4E-D7BA";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
    };
  };
}
