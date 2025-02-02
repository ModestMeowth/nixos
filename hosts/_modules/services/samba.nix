{ config, lib, ... }:
let
  cfg = config.services.samba;
in
{
  config.services.samba = lib.mkIf cfg.enable {
    openFirewall = true;

    settings.global = {
      "map to guest" = "bad user";
      "min protocol" = "SMB2";
    };
  };
}
