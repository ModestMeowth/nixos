{ config, lib, pkgs, ... }: with lib; let
  cfg = config.programs.firefox;
in
{
  config.programs.firefox = mkIf cfg.enable {
    package = pkgs.unstable.firefox;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
