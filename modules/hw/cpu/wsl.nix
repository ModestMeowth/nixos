{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.cpu == "wsl") {
#    assertions = [
#      {
#        assertion = !config.hostConfig.hw.secureboot;
#        message = ''
#          Secureboot and WSL cannot both be enabled
#        '';
#      }
#    ];

    wsl = {
      enable = true;
      wslConf.interop.appendWindowsPath = true;
      startMenuLaunchers = true;
    };

    # patch fixes https://github.com/microsoft/WSL/issues/8879
    systemd.package = pkgs.systemd.overrideAttrs (final: prev: {
      patchs =
        prev.patches
        ++ [
          ../../../patches/systemd-wslfix.patch
        ];
    });

    # fixes ssh over tailscale
    networking.interfaces.eth0.mtu = 1500;
    # allow wheel to fix mtu manually
    security.sudo.extraRules = [
      {
        groups = ["wheel"];
        commands = [
          {
            command = "/run/current-system/sw/bin/ip link set dev eth0 mtu 1500";
            options = ["SETENV" "NOPASSWD"];
          }
        ];
      }
    ];
  };
}
