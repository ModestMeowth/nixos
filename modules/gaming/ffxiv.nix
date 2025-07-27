{ config, lib, pkgs, ... }:
let cfg = config.gaming.ffxiv;
in {
  options.gaming.ffxiv.enable = lib.mkEnableOption "Final Fantasy XIV";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ xivlauncher ];
  };
}
