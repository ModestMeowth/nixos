{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hostConfig.hw = {
    secureboot = lib.mkEnableOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.hostConfig.hw.secureboot {
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };

    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
