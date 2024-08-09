{
  config,
  lib,
  ...
}: {
  options.hostConfig = {
    hw.wifi = lib.mkEnableOption "wifi";
    misc.regDom = lib.mkOption {
      type = lib.types.str;
      default = "US";
    };
  };

  config = lib.mkIf config.hostConfig.hw.wifi {
    hardware.wirelessRegulatoryDatabase = true;

    boot.extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="${config.hostConfig.misc.regDom}"
    '';
  };
}
