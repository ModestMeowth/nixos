{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hostConfig.wm.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf config.hostConfig.wm.gnome.enable {
    hostConfig.dm.gdm.enable = true;

    hostConfig.misc.fonts = true;
    hostConfig.misc.sound = true;
    hostConfig.misc.video = true;

    services.xserver.desktopManager.gnome.enable = true;

    environment = {
      systemPackages = with pkgs;
        [
          wl-clipboard
        ]
        ++ (with pkgs.gnome; [
          gnome-remote-desktop
          gnome-tweaks
        ]);

      gnome.excludePackages = with pkgs;
        [
          gnome-tour
          gedit
        ]
        ++ (with pkgs.gnome; [
          gnome-music
          epiphany
          geary
          totem
          iagno
          hitori
          atomix
        ]);
    };
  };
}
