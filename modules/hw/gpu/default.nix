{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./amd.nix
    ./intel.nix
    ./nvidia.nix
    ./vm.nix
  ];

  options.hostConfig = {
    hw.gpu = lib.mkOption {
      type = lib.types.enum [
        "amd"
        "intel"
        "nvidia"
        "vm"
      ];
    };

    misc.video = lib.mkEnableOption "video";
  };

  config = {
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
