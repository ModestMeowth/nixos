{config, lib, ...}: {
  options.hm-mm.browser.firefox = lib.mkEnableOption "firefox";

  config = lib.mkIf config.hm-mm.browser.firefox {
    programs.firefox.enable = true;
  };
}
