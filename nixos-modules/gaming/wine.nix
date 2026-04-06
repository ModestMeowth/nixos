{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.gaming.wine;
in
{
    environment.systemPackages = lib.mkIf cfg (with pkgs.wineWow64Packages; [
        stagingFull
        fonts
      ]);
}
