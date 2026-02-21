{ lib, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = lib.mkDefault true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };

    timeout = 3;
    systemd-boot = {
      configurationLimit = lib.mkDefault 5;
    };
  };
}
