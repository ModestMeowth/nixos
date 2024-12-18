{ config, lib, pkgs, ... }: with lib; let
  cfg = config.programs.chromium;
in
{
  config.programs.chromium = mkIf cfg.enable {
    package = (pkgs.unstable.chromium.override {
      commandLineArgs = [
        "--enable-features=Vulkan"
        "--flag-switches-begin"
        "--enable-unsafe-webgpu"
        "--flag-switches-end"
      ];
      enableWideVine = true;
    });
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock
    ];
  };
}
