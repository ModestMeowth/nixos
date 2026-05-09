{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.bottles;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [
      "com.usebottles.bottles"
    ];

    home.packages = lib.mkIf (!cfg.flatpak) [
      pkgs.bottles
    ];
  };
}
