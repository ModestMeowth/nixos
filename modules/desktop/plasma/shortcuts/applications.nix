{
  den.aspects.desktop._.plasma = {
    homeManager =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma.shortcuts = {
          "services/org.kde.konsole.desktop"._launch = mkDefault [ ];           # Ctrl+Alt+T
          "services/org.kde.emojier.desktop"._launch = mkDefault [ "Meta+." ];  # Meta+Ctrl+Alt+Shift+Space, Meta+.

          "services/systemdsettings.desktop".kcm_screen = mkDefault [ "Meta+Shift+P" ];

          "services/chromium-default.desktop"._launch = "Meta+D";
          "services/chromium-work.desktop"._launch = "Meta+Shift+D";
          "services/com.mitchellh.ghostty.desktop"._launch = "Meta+Return";
      };
    };
  };
}
