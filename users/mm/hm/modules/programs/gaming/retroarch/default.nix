{config, lib, pkgs, ...}: {
  options.hm-mm.gaming.retroarch = lib.mkEnableOption "retroarch";

  config = lib.mkIf config.hm-mm.gaming.retroarch {
    hm-mm.networking.syncthing = true;

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
