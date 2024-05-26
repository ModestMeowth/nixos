{pkgs, ...}: {
  imports = [
    ../syncthing.nix
  ];

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
}
