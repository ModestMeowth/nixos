{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let

  cfg = config.modules.hw.cpu;

in
{

  options.modules.hw.cpu = mkOption {
    type = lib.types.enum [
      "amd"
      "intel"
      "rpi"
      "vm"
      "wsl"
    ];
  };

  config = mkMerge [

    (mkIf (cfg == "amd") {

      hardware.cpu.amd.updateMicrocode = true;
      boot.kernelModules = [ "kvm-amd" ];
      environment.systemPackages = [ pkgs.pciutils ];

    })

    (mkIf (cfg == "intel") {

      hardware.cpu.amd.updateMicrocode = true;
      boot.kernelModules = [ "kvm-amd" ];
      environment.systemPackages = [ pkgs.pciutils ];

    })

    (mkIf (cfg == "rpi") {

    })

    (mkIf (cfg == "vm") {

    })

    (mkIf (cfg == "wsl") {

      wsl = {
        enable = true;
        wslConf.interop.appendWindowsPath = true;
        startMenuLaunchers = true;
      };

      networking.interfaces.eth0.mtu = 1500;

      security.sudo.extraRules = [
        {
          groups = [ "wheel" ];
          commands = [
            {
              command = "/run/current-system/sw/bin/ip link set dev eth0 mtu 1500";
              options = [
                "SETENV"
                "NOPASSWD"
              ];
            }
          ];
        }
      ];

    })

  ];

}
