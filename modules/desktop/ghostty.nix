{
  den.aspects.desktop._.ghostty = {
    homeManager =
      { config, ... }:
      let
        fonts = config.theming.fonts;
      in
      {
        programs.ghostty = {
          enable = true;
          settings = {
            font-family = [
              fonts.monospace.name
              fonts.emoji.name
            ];

            font-size = fonts.sizes.terminal;

            shell-integration = "detect";
            shell-integration-features = "no-cursor,ssh-env";

            window-padding-x = 8;
            window-padding-y = 8;

            window-theme = "ghostty";
            gtk-toolbar-style = "flat";

            cursor-style = "block";
            cursor-style-blink = false;

            confirm-close-surface = false;
            resize-overlay = "never";

            mouse-scroll-multiplier = 0.95;
            async-backend = "epoll";
          };
        };
      };
  };
}
