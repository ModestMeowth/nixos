{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.modules.wm;
in
{
  imports = [ ./gnome.nix ];

  config = mkIf (cfg.gnome.enable) {
    fonts.packages = with pkgs; [
      nerdfonts
      unifont
    ];

    security.rtkit.enable = true;

    sound.enable = mkDefault false;
    services.pipewire.enable = true;
  };
}
