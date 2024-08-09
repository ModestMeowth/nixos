{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.cpu == "amd") {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelModules = ["kvm-amd"];
  };
}
