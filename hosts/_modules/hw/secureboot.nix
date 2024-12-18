{config, lib, pkgs, ...}: with lib; let
  cfg = config.boot.lanzaboote;
in
{
  boot.loader = {
    grub.enable = mkForce false;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";

    systemd-boot.enable = mkForce (!cfg.enable);
    systemd-boot.configurationLimit = 5;
  };

  boot.lanzaboote.pkiBundle = mkIf cfg.enable "/etc/secureboot";
  environment.systemPackages = [pkgs.sbctl];
}
