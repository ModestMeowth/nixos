{ den, lib, ... }:
{
  den.aspects.desktop._.hyprland = {
    includes = [ den.aspects.desktop._.quickshell ];
    homeManager =
      {
        config,
        osConfig,
        pkgs,
        ...
      }:
      let
        inherit (builtins) readFile;
        inherit (lib) importJSON mergeAttrsList;
        mkBinFile =
          binDir:
          {
            source,
            target ? source,
          }:
          {
            "${binDir}/${target}" = {
              source = ../../../dotfiles/bin/${source};
              executable = true;
            };
          };
        mkBinFiles = binDir: list: mergeAttrsList (map (f: (mkBinFile binDir { source = f; })) list);

        fonts = config.theming.fonts;
        ts = osConfig.services.tailscale;
      in
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

        services = {
          hyprpaper.enable = true;
          hyprpolkitagent.enable = true;
          hyprsunset.enable = true;

          mako = {
            enable = true;
            extraConfig = ''
              font=${fonts.serif.name}
            ''
            + readFile ../../../dotfiles/mako/config;
          };

          tailscale-systray = lib.mkIf ts.enable {
            enable = true;
            package = ts.package;
          };

          swayosd.enable = true;
        };

        programs.waybar = {
          enable = true;
          systemd.enable = true;
          settings = importJSON ../../../dotfiles/waybar/config.jsonc;
          style = readFile ../../../dotfiles/waybar/style.css;
        };

        xdg = {
          configFile = mkBinFiles "waybar" [
            "idle-indicator.sh"
            "notification-silence-indicator.sh"
            "screen-recording-indicator.sh"
          ];

          portal.extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
            xdg-desktop-portal-kde
          ];
        };
      };
  };
}
