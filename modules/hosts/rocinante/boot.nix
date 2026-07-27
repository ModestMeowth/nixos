{ den, ... }: {
  den.aspects.rocinante = {
    includes = with den.aspects; [
      boot._.secure
      boot._.graphical
      kmscon
    ];

    nixos = {
      boot.loader.limine.resolution = "1920x1200x32";

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/B360-BBD9";
        fsType = "vfat";
        options = [
          "fmask=0177"
          "dmask=0077"
        ];
      };
    };
  };
}
