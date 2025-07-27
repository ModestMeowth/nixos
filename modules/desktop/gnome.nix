{ pkgs, ... }: {
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [ gnome-remote-desktop gnome-tweaks ];

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
