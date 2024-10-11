{config, lib, ...}: {
  options.hm-mm.networking.syncthing = lib.mkEnableOption "syncthing";

  config = lib.mkIf config.hm-mm.networking.syncthing {
    services.syncthing.enable = true;
  };
}
