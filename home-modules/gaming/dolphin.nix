{config, lib, pkgs, ...}:
let
  cfg = config.gaming.dolphin;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [
      "org.DolphinEmu.dolphin-emu"
    ];

    home.packages = lib.mkIf (!cfg.flatpak)[ pkgs.dolphin-emu ];
  };
}
