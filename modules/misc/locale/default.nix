{
  config,
  lib,
  ...
}: {
  options.hostConfig = {
    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
    };

    tz = lib.mkOption {
      type = lib.types.str;
      default = "America/Chicago";
    };
  };

  config = {
    i18n = {
      defaultLocale = config.hostConfig.locale;
      extraLocaleSettings = {
        LC_ADDRESS = config.hostConfig.locale;
        LC_IDENTIFICATION = config.hostConfig.locale;
        LC_MEASUREMENT = config.hostConfig.locale;
        LC_MONETARY = config.hostConfig.locale;
        LC_NAME = config.hostConfig.locale;
        LC_NUMERIC = config.hostConfig.locale;
        LC_PAPER = config.hostConfig.locale;
        LC_TIME = config.hostConfig.locale;
      };
    };

    time.timeZone = config.hostConfig.tz;
  };
}
