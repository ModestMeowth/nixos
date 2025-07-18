{ lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = lib.mkDefault true;

    excludePackages = with pkgs; [
      xterm
    ];
  };
}
