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
    enable = lib.mkDefault true;
    autoEnable = lib.mkDefault false;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";

    fonts = {
      serif.name = "0xProto Nerd Font Propo";
      serif.package = pkgs.nerd-fonts._0xproto;

      sansSerif.name = "Caskaydia Cove Nerd Font";
      sansSerif.package = pkgs.nerd-fonts.caskaydia-cove;

      monospace.name = "0xProto Nerd Font Mono";
      monospace.package = config.stylix.fonts.serif.package;

      emoji.name = "Noto-Color-Emoji";
      emoji.package = pkgs.nerd-fonts.noto;
    };

    targets = {
      font-packages.enable = lib.mkDefault false;
      fontconfig.enable = lib.mkDefault false;
    };
  };
}
