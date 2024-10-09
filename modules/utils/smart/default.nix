{config, lib, pkgs, ...}: {
  options.hostConfig.utils.smart = lib.mkEnableOption "smartmontools";

  config = lib.mkIf config.hostConfig.utils.smart {
    services.smartd.enable = true;
    environment.systemPackages = with pkgs; [
      nvme-cli
      smartmontools
    ];
  };
}
