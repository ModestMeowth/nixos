{ config, lib, ... }:
let
  cfg = config.fleet.hasEfi;
in
{
  options.fleet.hasEfi = lib.mkEnableOption "device uses efi";

  config = lib.mkIf cfg {
    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };
  };
}
