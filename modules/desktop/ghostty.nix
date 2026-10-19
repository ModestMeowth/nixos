{
  den.aspects.desktop._.ghostty = {
    homeManager = {
      # required if systemd > 262 until fixed 10/21/26
      xdg.configFile."systemd/user/app-com.mitchellh.ghostty.service.d/override.conf".text = ''
        [Service]
        Type=dbus
      '';

      programs.ghostty = {
        enable = true;
        settings = {
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
