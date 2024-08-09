{
  config,
  lib,
  ...
}: {
  options.hostConfig.dm.gdm = {
    enable = lib.mkEnableOption "gdm";
  };

  config = lib.mkIf config.hostConfig.dm.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
