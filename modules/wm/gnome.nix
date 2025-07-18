{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./fonts.nix
    ./gdm.nix
  ];

  services.xserver.desktopManager.gnome.enable = true;

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
}
