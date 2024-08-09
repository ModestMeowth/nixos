{
  lib,
  ...
}: {
  imports = [
    ./amd.nix
    ./intel.nix
    ./vm.nix
    ./wsl.nix
  ];

  options.hostConfig.hw.cpu = lib.mkOption {
    type = lib.types.enum [
      "amd"
      "intel"
      "vm"
      "wsl"
    ];
  };
}
