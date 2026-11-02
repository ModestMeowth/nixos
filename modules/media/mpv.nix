{den, ...}:
{
  den.aspects.media.mpv = {
    includes = with den.aspects; [
      desktop._
    ];

    homeManager =
      { pkgs, ... }:
      {
        programs.mpv = {
          enable = true;
          scripts = [
            pkgs.mpvScripts.builtins.autoload
          ]
          ++ (with pkgs.mpvScripts; [
            mpris
            thumbfast
          ]);
        };
      };
  };
}
