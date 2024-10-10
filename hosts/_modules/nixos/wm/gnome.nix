{config, lib, pkgs, ...}: with lib; let
  cfg = config.modules.wm.gnome;
in {
  options.modules.wm.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {

    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
    };

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
