{
  den.aspects.desktop =
    {
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
