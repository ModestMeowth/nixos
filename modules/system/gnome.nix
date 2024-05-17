{pkgs, ...}: {
  imports = [
    ./fonts.nix
    ./gdm.nix
  ];

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

    gnome.excludePackages =
      (with pkgs; [
        gnome-tour
        gedit
      ])
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
}
