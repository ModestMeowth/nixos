{
  config,
  lib,
  pkgs,
  ...
}:
{
  catppuccin = {
    enable = true;
    cache.enable = true;
  };

  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";

    fonts = lib.mkDefault {
      serif.name = "0xProto Nerd Font Propo";
      serif.package = pkgs.nerd-fonts._0xproto;

      sansSerif.name = "Caskaydia Cove Nerd Font";
      sansSerif.package = pkgs.nerd-fonts.caskaydia-cove;

      monospace.name = "0xProto Nerd Font Mono";
      monospace.package = pkgs.nerd-fonts._0xproto;

      emoji.name = "Noto-Color-Emoji";
      emoji.package = pkgs.nerd-fonts.noto;
    };

    image = ../dotfiles/wallpaper/wall.png;

    targets = {
      font-packages.enable = lib.mkDefault false;
      fontconfig.enable = lib.mkDefault false;
    };
  };
}
