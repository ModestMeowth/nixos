{
  lib,
  pkgs,
  ...
}:
{
  boot = {
    lanzaboote.enable = true;
    lanzaboote.pkiBundle = lib.mkDefault "/var/lib/sbctl";

    loader.grub.enable = lib.mkForce false;
    loader.systemd-boot.enable = lib.mkForce false;
  };

  environment.systemPackages = [ pkgs.sbctl ];
}
