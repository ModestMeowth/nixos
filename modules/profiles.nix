{ den, ... }:
{
  den.aspects.profiles = {
    base = {
      includes = with den.aspects; [
        filesystems
        networking
      ];
    };

    laptop.includes = with den.aspects; [
      profiles.workstation
      networking.wireless
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
