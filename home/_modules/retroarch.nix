{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.gaming.retroarch;
in
{
  options.modules.gaming.retroarch.enable = mkEnableOption "retroarch";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (retroarch.override {
        cores = with libretro; [
          desmume
          fceumm
          mgba
          parallel-n64
          pcsx-rearmed
          snes9x
        ];
      })
      retroarch-assets
      retroarch-joypad-autoconfig
    ];
  };
}
