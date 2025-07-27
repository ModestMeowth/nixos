{ config, lib, pkgs, ... }:
let cfg = config.boot.lanzaboote;
in {
  environment.systemPackages = [ pkgs.sbctl ];
  boot.loader = {
    grub.enable = lib.mkForce false;
    systemd-boot = {
      enable = lib.mkForce (!cfg.enable);
      configurationLimit = 5;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.lanzaboote.pkiBundle = lib.mkIf cfg.enable "/etc/secureboot";
}
