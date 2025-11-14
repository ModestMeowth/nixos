{ config, lib, pkgs, ... }:
let cfg = config.gaming.emulation;
in {
  options.gaming.emulation.enable = lib.mkEnableOption "retroarch";

  config.environment.systemPackages = lib.mkIf cfg.enable (with pkgs; [
    (retroarch.withCores (cores:
      with cores; [
        bsnes
        desmume
        dolphin
        fceumm
        flycast
        mgba
        parallel-n64
        swanstation
      ]))
    retroarch-assets
    retroarch-joypad-autoconfig
    pcsx2
    dolphin-emu
    azahar
  ]);
}
