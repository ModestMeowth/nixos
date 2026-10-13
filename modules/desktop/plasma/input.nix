{
  den.aspects.desktop._.plasma = {
    homeManager =
      { lib, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          input = {
            keyboard = {
              model = mkDefault "pc105";
              numlockOnStartup = mkDefault "on";
              options = [ "compose:ralt" ];
            };
          };

          shortcuts = {
            "KDE Keyboard Layout Switcher" = {
              "Switch to Last-Used Keyboard Layout" = mkDefault [ ];  # Meta+Alt+L
              "Switch to Next Keyboard Layout" = mkDefault [ ];       # Meta+Alt+K
            };

            "services/org.kde.touchpadshortcuts.desktop" = {
              DisableTouchpad = mkDefault [ ];                        # Touchpad On
              EnableTouchpad = mkDefault [ ];                         # Touchpad Off
              ToggleTouchpad = mkDefault [ ];                         # Touchpad Toggle, Meta+Ctrl+Zenkaku Hankaku, Meta+Ctrl+Touchpad Toggle
            };
          };

          configFile.kxkbrc.Layout.ResetOldOptions = mkDefault true;
        };
      };
  };
}
