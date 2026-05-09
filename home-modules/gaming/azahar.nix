{config, lib, pkgs, ...}:
let
  cfg = config.gaming.azahar;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [
      "org.azahar_emu.Azahar"
    ];

    home.packages = lib.mkIf (!cfg.flatpak) [ pkgs.azahar ];
  };
}
