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

        xdg.portal.extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-kde
          ];
      };
  };
}
