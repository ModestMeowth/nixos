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
  environment.systemPackages = lib.mkIf cfg [pkgs.xivlauncher];
}
