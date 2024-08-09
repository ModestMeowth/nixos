{
  lib,
  ...
}: {
  options.hostConfig.hw.chassis = lib.mkOption {
    type = lib.types.enum [
      "laptop"
      "server"
      "workstation"
      "vm"
      "wsl"
    ];
  };

  imports = [
    ./laptop
    ./server
    ./workstation
    ./vm
    ./wsl
  ];
}
