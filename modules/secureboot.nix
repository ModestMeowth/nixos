{ config, lib, pkgs, ... }:
let
  cfg = config.boot.lanzaboote;
in
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      grub.enable = lib.mkForce false;

      systemd-boot = lib.mkIf cfg.enable {
        enable = lib.mkForce (!cfg.enable);
        configurationLimit = 5;
      };
    };

    lanzaboote.pkiBundle = lib.mkIf cfg.enable "/etc/secureboot";
  };
}
