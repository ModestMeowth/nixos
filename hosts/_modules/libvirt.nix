{config, ...}: let
  cfg = config.virtualisation.libvirt;
in
{
  config.virtualisation.libvirt.swtpm.enable = cfg.enable;
}
