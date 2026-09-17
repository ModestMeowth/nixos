{
  den.aspects.desktop._.hyprland = {
    homeManager =
      { pkgs,... }:
      {
        home.packages = with pkgs; [
          hyprpolkitagent
          hyprpicker
          hyprshutdown

          libxkbcommon # xkbcli
          playerctl
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
