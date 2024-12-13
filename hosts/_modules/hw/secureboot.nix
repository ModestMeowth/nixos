{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.hw.secureboot;
in
{
  options.modules.hw.secureboot.enable = mkEnableOption "secureboot";

  config = mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = mkForce false;
      configurationLimit = 5;
    };

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
