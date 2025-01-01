{ config, lib, pkgs, ... }:
let
  cfg = config.gaming.retroarch;
in
{
  options.gaming.retroarch.enable = lib.mkEnableOption "retroarch";

  config.environment.systemPackages = lib.mkIf cfg.enable (with pkgs; [
    (retroarch.override {
      cores = with libretro; [
        desmume
        dolphin
        fceumm
        flycast
        mgba
        parallel-n64
        pcsx-rearmed
        pcsx2
        snes9x
      ];
    })
    retroarch-assets
    retroarch-joypad-autoconfig
  ]);
}
