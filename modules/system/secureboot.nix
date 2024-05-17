{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.secBoot.nixosModules.lanzaboote
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
