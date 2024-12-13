{ config, lib, ... }: with lib; let
  cfg = config.modules.services.samba;
in
{
  options.modules.services.samba.enable = mkEnableOption "samba";

  config.services.samba = mkIf cfg.enable {
    enable = true;
    openFirewall = true;

    settings.global = {
      "map to guest" = "bad user";
      "min protocol" = "SMB2";
    };
  };
}
