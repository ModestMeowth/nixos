{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.rpcs3;
in
{
  config = lib.mkIf cfg.enable {
    services.flatpak.packages = lib.mkIf cfg.flatpak [ "net.rpcs3.RPCS3" ];

    home.packages = lib.mkIf (!cfg.flatpak) [ pkgs.rpcs3 ];
  };
}
