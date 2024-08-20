{config, lib, ...}: let
  cfg = config.hostConfig.utils.fwupd;
in {
  options.hostConfig.utils.fwupd = {
    enable = lib.mkEnableOption "fwupd";
  };

  config = lib.mkIf cfg.enable {
    services.fwupd = {
      enable = true;
    };
  };
}
