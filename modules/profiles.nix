{ den, ... }:
{
  den.aspects.profiles = {
    base = {
      includes = with den.aspects; [
        hw.fs
        net
      ];
    };

    laptop.includes = with den.aspects; [
      profiles.workstation
      net.wireless
    ];

    server.includes = with den.aspects; [
      profiles.base
      boot
    ];

    workstation.includes = with den.aspects; [
      profiles.base
      boot._.graphical
      flatpak
      yubikey
    ];
  };
}
