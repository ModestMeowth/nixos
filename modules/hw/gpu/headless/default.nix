{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.hostConfig.hw.gpu != "headless") {
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      clinfo
    ];
  };
}
