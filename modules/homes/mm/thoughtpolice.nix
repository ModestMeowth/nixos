{ den, ... }:
{
  den.homes.x86_64-linux."mm@thoughtpolice" = { };

  den.aspects.mm._.thoughtpolice = {
    includes = with den.aspects; [
      wm.plasma.plugins.krohnkite

      term.ghostty
      media.mpv
      www.chromium
    ];

    homeManager =
      {pkgs, ...}:
      {
        home.packages = [ pkgs.filezilla ];
      };
  };
}
