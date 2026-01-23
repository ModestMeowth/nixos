{ config, lib, ... }:
let
  cfg = config.fleet.useEfi;
in
{
  options.fleet.useEfi = lib.mkEnableOption "device uses efi";

  config = lib.mkIf cfg {
    boot.loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = lib.mkDefault "/boot";
    };
  };
}
