{ config, lib, ... }: with lib; let
  cfg = config.services.chrony;
in
{
  config.services.chrony.extraConfig = mkIf cfg.enable #conf
    ''
      allow all
      bindaddress 0.0.0.0
    '';
}
