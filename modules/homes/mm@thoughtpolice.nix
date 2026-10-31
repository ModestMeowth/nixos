{ den, ... }:
{
  den.homes.x86_64-linux."mm@thoughtpolice" = { };

  den.aspects.mm._.thoughtpolice = {
    includes = with den.aspects; [
      mm
    ]
    ++
    (with desktop._; [
      plasma
      plasma._.krohnkite
      chromium
      ghostty
    ]);

    homeManager =
      {pkgs, ...}:
      {
        home.packages = [ pkgs.filezilla ];
      };
  };
}
