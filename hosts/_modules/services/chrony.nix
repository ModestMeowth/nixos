{ config, lib, ... }: with lib; let
  cfg = config.modules.services.chrony;
in
{
  options.modules.services.chrony.enable = lib.mkEnableOption "chrony";

  config.services.chrony = mkIf cfg.enable {
    enable = true;
    extraConfig = ''
      allow all
      bindaddress 0.0.0.0
    '';
  };
}
