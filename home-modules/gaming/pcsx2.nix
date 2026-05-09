{config, lib, pkgs, ...}:
let
  cfg = config.gaming.pcsx2;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [
      "net.pcsx2.PCSX2"
    ];

    home.packages = lib.mkIf (!cfg.flatpak) [ pkgs.pcsx2 ];
  };
}
