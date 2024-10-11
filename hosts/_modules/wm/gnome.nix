{config, lib, pkgs, ...}: with lib; let

  cfg = config.modules.wm.gnome;

in {
  options.modules.wm.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {

    services.xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;

      desktopManager.gnome.enable = true;
    };

    environment. systemPackages = with pkgs; [
      wl-clipboard
      gnome.gnome-remote-desktop
      gnome.gnome-tweaks
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gedit
      gnome.gnome-music
      gnome.epiphany
      gnome.geary
      gnome.totem
      gnome.iagno
      gnome.hitori
      gnome.atomix
    ];
  };
}
