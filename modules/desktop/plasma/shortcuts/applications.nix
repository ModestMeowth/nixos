{
  den.aspects.desktop._.plasma = {
    homeManager =
      {lib, ...}:
      {
        programs.plasma.shortcuts = {
          "services/chromium-default.desktop"._launch = "Meta+D";
          "services/chromium-work.desktop"._launch = "Meta+Shift+D";
          "services/com.mitchellh.ghostty.desktop"._launch = "Meta+Return";
          "services/org.kde.konsole.desktop"._launch = [ ];
        };
      };
  };
}
