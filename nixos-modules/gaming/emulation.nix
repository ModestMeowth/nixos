{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.emulation;
in
{
  options.gaming.emulation = lib.mkEnableOption "retroarch";

  config = lib.mkIf cfg {
    environment = {
      systemPackages = with pkgs; [
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
        pcsx2
        dolphin-emu
        azahar
      ];
    };
  };
}
