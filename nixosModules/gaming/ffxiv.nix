{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.ffxiv;
in
{
  options.gaming.ffxiv = lib.mkEnableOption "Final Fantasy XIV";

  config = lib.mkIf cfg {
    environment = {
      systemPackages = [ pkgs.xivlauncher ];
    };
  };
}
