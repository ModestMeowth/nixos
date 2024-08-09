{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.cpu == "intel") {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelModules = ["kvm-intel"];
  };
}
