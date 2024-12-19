{ config, lib, pkgs, ... }:
let
  cfg = config.programs.chromium;
in
{
  config.programs.chromium = lib.mkIf cfg.enable {
    package = (pkgs.unstable.chromium.override {
      commandLineArgs = [
        "--enable-features=Vulkan"
      ];
      enableWideVine = true;
    });
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock
    ];
  };
}
