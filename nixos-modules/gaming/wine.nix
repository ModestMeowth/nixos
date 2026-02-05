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
  options.gaming.wine = lib.mkEnableOption "wine";

  config = lib.mkIf cfg {
    environment = {
      systemPackages = with pkgs.wineWow64Packages; [
        stagingFull
        fonts
      ];
    };
  };
}
