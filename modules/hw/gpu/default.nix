{
  lib,
  ...
}: {
  imports = [
    ./amd
    ./headless
    ./intel
    ./nvidia
    ./vm
  ];

  options.hostConfig.hw.gpu = lib.mkOption {
    type = lib.types.enum [
      "amd"
      "headless"
      "intel"
      "nvidia"
      "vm"
    ];
  };

  options.hostConfig.misc.video = lib.mkEnableOption "video";
}
