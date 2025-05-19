{ config, lib, pkgs, ... }:
let
  cfg = config.services.xserver.desktopManager.gnome;
in
{
  config = lib.mkIf cfg.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.droid-sans-mono
      nerd-fonts.noto
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-sans
      nerd-fonts.ubuntu-mono
      unifont
    ];

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;

      excludePackages = with pkgs; [
        xterm
      ];

      desktopManager.xterm.enable = false;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      gnome-remote-desktop
      gnome-tweaks
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gedit
      gnome-music
      epiphany
      geary
      totem
      iagno
      hitori
      atomix
    ];

    security.rtkit.enable = true;
    services.pipewire.enable = true;
  };
}
