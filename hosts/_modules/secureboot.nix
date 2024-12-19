{ config, lib, pkgs, ... }:
let
  cfg = config.wsl;
  cfgSecureBoot = config.boot.lanzaboote;
in
{
  config = lib.mkIf (!cfg.enable) {
    boot.loader = {
      grub.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      systemd-boot.enable = lib.mkForce (!cfgSecureBoot.enable);
      systemd-boot.configurationLimit = 5;
    };

    boot.lanzaboote.pkiBundle = lib.mkIf cfgSecureBoot.enable "/etc/secureboot";
    environment.systemPackages = [ pkgs.sbctl ];
  };
}
