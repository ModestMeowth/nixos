{config, lib, pkgs, ...}: with lib; let
  cfg = config.wsl;
  cfgSecureBoot = config.boot.lanzaboote;
in
{
  config = mkIf (!cfg.enable) {
    boot.loader = {
      grub.enable = mkForce false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      systemd-boot.enable = mkForce (!cfgSecureBoot.enable);
      systemd-boot.configurationLimit = 5;
    };

    boot.lanzaboote.pkiBundle = mkIf cfgSecureBoot.enable "/etc/secureboot";
    environment.systemPackages = [pkgs.sbctl];
  };
}
