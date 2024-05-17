{
  inputs,
  pkgs,
  ...
}: {
  system.stateVersion = "24.05";

  imports = [
    inputs.wsl.nixosModules.default
    ./common.nix
  ];

  wsl = {
    enable = true;
    wslConf = {
      interop.appendWindowsPath = true;
    };
    startMenuLaunchers = true;
  };

  # patch fixes https://github.com/microsoft/WSL/issues/8879
  systemd.package = pkgs.systemd.overrideAttrs (final: prev: {
    patches =
      prev.patches
      ++ [
        ../../patches/systemd-wslfix.patch
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
}
