{den, ...}:
{
  den.aspects.profile = {
    includes = with den.aspects; [
      hw.fs
      net
    ];

    nixos = {
      
    };
  };
}
