{
  lib,
  ...
}: {
  imports = [
    ./amd
    ./intel
    ./rpi
    ./vm
    ./wsl
  ];

  options.hostConfig.hw.cpu = lib.mkOption {
    type = lib.types.enum [
      "amd"
      "intel"
      "rpi"
      "vm"
      "wsl"
    ];
  };
}
