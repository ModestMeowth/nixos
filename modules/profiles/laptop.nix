{den, ...}:
{
  den.aspects.profile.laptop = {
    includes = with den.aspects; [
      profile
      profile.workstation
      net.wireless
    ];

    nixos = {
      
    };
  };
}
