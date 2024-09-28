{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hostConfig.utils.tailscale = {
    enable = lib.mkEnableOption "tailscale";
  };

  config = lib.mkIf config.hostConfig.utils.tailscale.enable {
    services.tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
    };
  };
}
