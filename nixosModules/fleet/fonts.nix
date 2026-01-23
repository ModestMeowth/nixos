{ config, lib, pkgs, ...}:
let
  cfg = config.fleet;
in
{
  config = lib.mkIf (cfg.isLaptop || cfg.isDesktop) {
    fonts = {
      packages = with pkgs.nerd-fonts; [
        _0xproto
        caskaydia-cove
        noto
        symbols-only
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["0xProto Nerd Font Propo"];
          sansSerif = ["Caskyadia Cove Nerd Font"];
          monospace = ["0xProto Nerd Font Mono"];
          emoji = ["Noto-Color-Emoji"];
        };
      };
    };
  };
}
