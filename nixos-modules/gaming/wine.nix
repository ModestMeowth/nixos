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
    config = lib.mkIf cfg {
      boot.kernelModules = [ "ntsync" ];
      environment.systemPackages = lib.mkIf cfg (with pkgs.wineWow64Packages; [
          stagingFull
          fonts
        ]);
    };
}
