{ lib, ... }:
{
  # Override the enum, my ultrawide has modes 0-4, the laptop has 0-10
  options.boot.loader.systemd-boot.consoleMode = lib.mkOption {
    type = lib.types.enum [
      "0"
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "10"
      "auto"
      "max"
      "keep"
    ];
  };

  config.boot.loader = {
    efi = {
      canTouchEfiVariables = lib.mkDefault true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };

    systemd-boot.configurationLimit = 5;
    timeout = 3;
  };
}
