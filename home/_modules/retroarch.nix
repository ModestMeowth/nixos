{ config, lib, pkgs, ... }:
let
  cfg = config.gaming.retroarch;
in
{
  options.gaming.retroarch.enable = lib.mkEnableOption "retroarch";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (retroarch.override {
        cores = with libretro; [
          desmume
          fceumm
          flycast
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
