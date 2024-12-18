{config, lib, pkgs, ...}: with lib; let
  cfg = config.wsl;
in
{
  config = mkIf (!cfg.enable) {
    boot.loader = {
      grub.enable = mkForce false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      systemd-boot.enable = mkForce (!config.boot.lanzaboote);
      systemd-boot.configurationLimit = 5;
    };

    boot.lanzaboote.pkiBundle = mkIf cfg.enable "/etc/secureboot";
    environment.systemPackages = [pkgs.sbctl];
  };
}
