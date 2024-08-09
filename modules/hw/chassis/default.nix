{
  config,
  lib,
  ...
}: {
  options.hostConfig.hw.chassis = {
    type = lib.mkOption {
      type = lib.types.enum [
        "laptop"
        "gaming"
        "server"
        "workstation"
      ];
    };

    headless = lib.mkEnableOption "headless";
  };

  config = lib.mkMerge [
    (lib.mkIf (config.hostConfig.hw.chassis.type == "laptop") {
      hostConfig.hw.wifi = true;

      hostConfig.misc.video = true;
      hostConfig.misc.sound = true;
    })
    (lib.mkIf (config.hostConfig.hw.chassis.type == "gaming") {
      hostConfig.misc.video = true;
      hostConfig.misc.sound = true;
    })
    (lib.mkIf (config.hostConfig.hw.chassis.type == "server") {
      hostConfig.misc.video = !config.hw.chassis.headless;
    })
    (lib.mkIf (config.hostConfig.hw.chassis.type == "workstation") {
      hostConfig.misc.video = true;
      hostConfig.misc.sound = true;
    })
  ];
}
