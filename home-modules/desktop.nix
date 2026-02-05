{ config, inputs, pkgs, ... }:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  gtk = {
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home.packages = with pkgs; [
      bitwarden-desktop
      google-chrome
      signal-desktop
      rpi-imager
    ];

  programs.ghostty.enable = true;

  services = {
    udiskie = {
      enable = true;
      settings.program_options = {
        file_manager =
          "${config.programs.ghostty.package}/bin/ghostty -e ${config.programs.yazi.package}/bin/yazi";
      };
    };
  };

  stylix = {
    enable = true;
    autoEnable = false;

    cursor = {
      name = "Catppuccin Macchiato Mauve";
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      size = 24;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    fonts = {
      serif.name = "0xProt Nerd Font Propo";
      serif.package = pkgs.nerd-fonts._0xproto;

      sansSerif.name = "Caskaydia Cove Nerd Font";
      sansSerif.package = pkgs.nerd-fonts.caskaydia-cove;

      monospace.name = "0xProt Nerd Font Mono";
      monospace.package = pkgs.nerd-fonts._0xproto;

      emoji.name = "Noto-Color-Emoji";
      emoji.package = pkgs.nerd-fonts.noto;
    };

    targets.gtk = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };

  xdg.configFile = {
    "nebula.jpeg".source = ../dotfiles/wallpaper/nebula.jpeg;
    "Cat.png".source = ../dotfiles/wallpaper/Cat.png;
    "dark-cat-rosewater.png".source = ../dotfiles/wallpaper/dark-cat-rosewater.png;
    "face.png".source = ../dotfiles/wallpaper/face.png;
    "ghostty" = {
      source = ../dotfiles/ghostty;
      recursive = true;
    };
  };
}
