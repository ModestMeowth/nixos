{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.fleet;
in
{
  options.fleet.useSecureboot = lib.mkEnableOption "device uses secureboot";

  options.boot.lanzaboote = {
    enable = lib.mkEnableOption "Enable the LANZABOOTE";
    pkiBundle = lib.mkOption {
      type = lib.types.nullOr lib.types.externalPath;
      description = "PKI bundle containing db, PK, KEK";
    };
  };

  config = lib.mkIf cfg.useSecureboot {
    fleet.useEfi = true;
    boot = {
      lanzaboote.enable = true;
      lanzaboote.pkiBundle = lib.mkDefault "/var/lib/sbctl";

      loader.grub.enable = lib.mkForce false;
      loader.systemd-boot.enable = lib.mkForce false;
    };

    environment.systemPackages = [ pkgs.sbctl ];
  };
}
