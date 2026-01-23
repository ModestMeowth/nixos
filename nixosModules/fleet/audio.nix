{config, lib, pkgs, ...}:
let
  cfg = config.fleet;
in
{
  config = lib.mkIf (cfg.isLaptop || cfg.isDesktop) {
    environment.systemPackages = with pkgs; [
      pwvucontrol
      wiremix
      xdg-utils
    ];

    hardware.bluetooth.enable = true;
    security.rtkit.enable = true;

    services = {
      blueman.enable = true;
      pipewire.enable = true;
    };
  };
}
