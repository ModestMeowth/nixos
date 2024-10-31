{config, lib, ...}: with lib; let
  cfg = config.modules.virt;
in {
  options.modules.virt.enable = mkEnableOption "virt";

  config.virtualisation.libvirt = mkIf cfg.enable {
    enable = true;
    swtpm.enable = true;
  };
}
