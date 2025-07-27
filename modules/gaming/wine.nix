{ config, lib, pkgs, ... }:
let cfg = config.gaming.wine;
in {
  options.gaming.wine.enable = lib.mkEnableOption "wine";

  config.environment.systemPackages =
    lib.mkIf cfg.enable (with pkgs.wineWow64Packages; [ stagingFull fonts ]);
}
