{ pkgs, ... }:
let
  gtkSettings = ''
    [Settings]
    gtk-theme-name=Dracula
    gtk-icon-theme-name=Nordzy-cursors-white
    gtk-cursor-theme-size=24
    gtk-font-name=Sans 10
  '';
in {
  environment.systemPackages = with pkgs; [
    dracula-theme
    dracula-icon-theme
    libsForQt5.qt5ct
    nordzy-cursor-theme
    catppuccin-gtk
    catppuccin-cursors
  ];

  environment.variables = {
    XCURSOR_THEME = "Nordzy-cursors-white";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Dracula";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  environment.etc = {
    "gtk-2.0/gtkrc".text = gtkSettings;
    "gtk-3.0/settings.ini".text = ''
      ${gtkSettings}
      gtk-application-prefer-dark-theme=1
    '';
    "gtk-4.0/settings.ini".text = ''
      ${gtkSettings}
      gtk-application-prefer-dark-theme=1
    '';
  };

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
    Xcursor.theme: Nordzy-cursors-white
    Xcursor.size: 24
    EOF
  '';

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "gtk2";
  };

  programs.dconf.enable = true;
  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
