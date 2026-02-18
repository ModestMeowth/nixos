{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot = {
    lanzaboote = {
      enable = true;
      autoGenerateKeys.enable = lib.mkDefault true;
      autoEnrollKeys = {
        enable = lib.mkDefault true;
        autoReboot = lib.mkDefault true;
      };

      pkiBundle = lib.mkDefault "/var/lib/sbctl";
    };

    loader.grub.enable = lib.mkForce false;
    loader.systemd-boot.enable = lib.mkForce false;
  };

  environment.systemPackages = [ pkgs.sbctl ];
}
