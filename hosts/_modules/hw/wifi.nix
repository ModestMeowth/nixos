{ config, lib, ... }: with lib; let
  cfg = config.modules.hw.wifi;
in
{
  options.modules.hw.wifi = {
    enable = mkEnableOption "wifi";
    regdom = mkOption {
      type = types.str;
      default = "US";
    };
  };

  config = mkIf cfg.enable {
    hardware.wirelessRegulatoryDatabase = true;
    boot.extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="${cfg.regdom}"
    '';
  };
}
