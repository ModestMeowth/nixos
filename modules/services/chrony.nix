{ config, lib, ... }:
let cfg = config.services.chrony;
in {
  config.services.chrony.extraConfig = lib.mkIf cfg.enable # conf
    ''
      allow all
      bindaddress 0.0.0.0
    '';
}
