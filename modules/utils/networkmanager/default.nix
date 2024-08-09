{
  config,
  lib,
  ...
}: {
  options.hostConfig.utils = {
    nm.enable = lib.mkEnableOption "NetworkManager";
  };

  config = lib.mkIf config.hostConfig.utils.nm.enable {
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
