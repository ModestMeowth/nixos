{ inputs, ... }:
{
  den.aspects.desktop._.hyprland = {
    homeManager =
      { config, ... }:
      let
        inherit (builtins) readFile;
        fonts = config.theming.fonts;
      in
      {
        services.hypridle = {
          enable = true;
          settings.source = inputs.self + /dotfiles/hypr/hypridle.conf;
        };

        catppuccin.hyprlock.useDefaultConfig = false;
        programs.hyprlock = {
          enable = true;
          package = null;
          settings."$fonts" = fonts.sansSerif.name;
          extraConfig = readFile (inputs.self + /dotfiles/hypr/hyprlock.conf);
        };

        xdg.configFile = {
          "screensaver" = {
            source = inputs.self + /dotfiles/screensaver;
            recursive = true;
          };
        };
      };
  };
}
