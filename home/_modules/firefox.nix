{ config, lib, pkgs, ... }:
let
  cfg = config.programs.firefox;
in
{
  config.programs.firefox = lib.mkIf cfg.enable {
    package = pkgs.unstable.firefox;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
