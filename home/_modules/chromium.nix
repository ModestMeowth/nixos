{ config, lib, pkgs, ... }: with lib; let
  cfg = config.programs.chromium;
in
{
  config.programs.chromium = mkIf cfg.enable {
    package = pkgs.unstable.chromium;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock
    ];
  };
}
