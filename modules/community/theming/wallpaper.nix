{
  theming.wallpaper = {
    homeManager =
      {config, lib, ...}:
      let
        inherit (lib) mkOption toList types;
        cfg = config.theming;
        HOME = config.home.homeDirectory;

      in
      {
        options.theming = {
          wallpaper = mkOption {
            type = with types; either path (listOf path);
            apply = p: toList p;
            default = [];
            description = "A path or list of paths to add to config.theming.wallpaperPath";
          };

          wallpaperPath = mkOption {
            type = types.str;
            default = "${HOME}/.wallpaper";
          };
        };

        config = {
           home.file = lib.foldl'
             (acc: p: acc // { "${cfg.wallpaperPath}/${baseNameOf (builtins.unsafeDiscardStringContext p)}".source = p; }) {} cfg.wallpaper;
        };
      };
  };
}
