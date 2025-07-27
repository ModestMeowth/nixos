{ lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libsForQt5.kdeconnect-kde
    xdg-utils
    syncthing
  ];

  services.flatpak.enable = lib.mkDefault false;
}
