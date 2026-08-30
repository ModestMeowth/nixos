{
  den.aspects.desktop._.hyprland = {
    homeManager =
      { pkgs,... }:
      {
        home.packages = with pkgs; [
          hyprpolkitagent
          hyprpicker
          hyprshutdown

          bluetui
          grim
          libxkbcommon # xkbcli
          playerctl
          satty
          slurp
          terminaltexteffects
        ];

        xdg.portal = {
          config = {
            common.default = [ "gtk" ];
            hyprland = {
              default = [
                "hyprland"
                "gtk"
              ];

              "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
            };
          };
        };
      };
  };
}
