{ lib, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = lib.mkDefault true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };

    systemd-boot.configurationLimit = lib.mkDefault 5;
  };
}
