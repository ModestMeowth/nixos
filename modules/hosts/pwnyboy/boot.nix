{ den, ... }:
{
  den.aspects.pwnyboy = {
    includes = with den.aspects; [
      boot._.secure
      kmscon
    ];

    nixos = {
      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/F8B6-B30E";
        fsType = "vfat";
        options = [
          "fmask=0177"
          "dmask=0077"
        ];
      };
    };
  };
}
