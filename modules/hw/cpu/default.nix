{
  lib,
  ...
}: {
  imports = [
    ./amd
    ./intel
    ./rpi
    ./vm
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
