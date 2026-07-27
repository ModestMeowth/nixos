{ inputs, ... }:
{
  den.aspects.desktop._.walker = {
    homeManager =
      { config, lib, ... }:
      let
        inherit (builtins) readFile;
        inherit (config.catppuccin) accent flavor sources;

        lua = lib.generators.mkLuaInline;

        css = sources.waybar;
      in
      {
        services = {
          elephant.enable = true;

          walker = {
            enable = true;
            systemd.enable = true;

            settings = fromTOML (readFile (inputs.self + /dotfiles/walker/config.toml));

            theme = {
              style = # css
              ''
                @import url(${css}/${flavor}.css);

                @define-color accent @${accent};
                @define-color border @text;
                @define-color foreground @text;
                @define-color background @base;
                @define-color selected-text @surface2;
              ''
              + readFile (inputs.self + /dotfiles/walker/themes/style.css);
              layout.nixos = inputs.self + /dotfiles/walker/themes/layout.xml;
            };
          };
        };

        wayland.windowManager.hyprland.settings.bind = [
          {
            _args = [
              "SUPER+SPACE"
              (
                # lua
                lua ''hl.dsp.exec_cmd("launch-walker")''
              )
              { description = "App launcher"; }
            ];
          }
        ];
      };
  };
}
