{den, ...}:
{
  den.aspects.profile.workstation = {
    includes = with den.aspects; [
      profile
      boot.graphical

      svc.flatpak
    ];

    nixos = {
      
    };
  };
}
