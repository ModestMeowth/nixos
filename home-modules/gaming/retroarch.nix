{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.retroarch;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [ "org.libretro.RetroArch" ];

    home.packages = lib.mkIf (!cfg.flatpak) (
      with pkgs;
      [
        (retroarch.withCores (
          cores: with cores; [
            bsnes
            desmume
            fceumm
            flycast
            genesis-plus-gx
            mgba
            parallel-n64
            ppsspp
            swanstation
          ]
        ))
        retroarch-assets
        retroarch-joypad-autoconfig
      ]
    );
  };
}
