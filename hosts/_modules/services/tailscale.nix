{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let

  cfg = config.modules.services.tailscale;

in
{
  options.modules.services.tailscale = {
    enable = mkEnableOption "tailscale";

    package = mkPackageOption pkgs "tailscale" { };

    authKey = mkOption {
      type = types.nullOr types.path;
      default = null;
    };

    ssh = mkOption {
      type = types.bool;
      default = false;
    };

  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;

      authKeyFile = cfg.authKey;

      extraSetFlags = mkIf cfg.ssh [ "--ssh" ];

      extraUpFlags = mkIf cfg.ssh [ "--ssh" ];

      inherit (cfg) package;
    };
  };
}
