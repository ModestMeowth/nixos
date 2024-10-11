{config, lib, ...}: {
  options.hm-mm.networking.k9s = lib.mkEnableOption "k9s";

  config = lib.mkIf config.hm-mm.networking.k9s {
    programs.k9s.enable = true;
  };
}
