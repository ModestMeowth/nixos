{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.cpu == "wsl") {

    wsl = {
      enable = true;
      wslConf.interop.appendWindowsPath = true;
      startMenuLaunchers = true;
    };

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
