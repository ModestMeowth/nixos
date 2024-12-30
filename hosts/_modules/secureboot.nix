{ config, lib, pkgs, ... }:
let
  cfg = config.wsl;
  cfgSecureBoot = config.boot.lanzaboote;
in
{
  config = lib.mkIf (!cfg.enable) {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      grub.enable = lib.mkDefault false;
      systemd-boot.enable = lib.mkForce (!cfgSecureBoot.enable);
      systemd-boot.configurationLimit = 5;
    };

    boot.lanzaboote.pkiBundle = lib.mkIf cfgSecureBoot.enable "/etc/secureboot";
    environment.systemPackages = [ pkgs.sbctl ];
  };
}
