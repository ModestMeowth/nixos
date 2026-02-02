{ config, lib', pkgs, ... }:
{
  gtk = {
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  home = {
    file = {
      ".local/bin/powermenu".source = lib'.mkDotfile "bin/powermenu";
      ".local/bin/toggle-dnd".source = lib'.mkDotfile "bin/toggle-dnd";
      ".local/bin/toggle-idle".source = lib'.mkDotfile "bin/toggle-idle";
    };

    packages = with pkgs; [
      bitwarden-desktop
      bootdev-cli
      google-chrome
      nmap
      signal-desktop
      rpi-imager
      virt-manager
      wireshark
    ];
  };

  programs.ghostty.enable = true;

  services = {
    syncthing.enable = true;
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
    "nebula.jpeg".source = lib'.mkDotfile "wallpaper/nebula.jpeg";
    "Cat.png".source = lib'.mkDotfile "wallpaper/Cat.png";
    "dark-cat-rosewater.png".source = lib'.mkDotfile "wallpaper/dark-cat-rosewater.png";
    "face.png".source = lib'.mkDotfile "wallpaper/face.png";
    "ghostty".source = lib'.mkDotfile "ghostty";
    "hypr".source = lib'.mkDotfile "hypr";
    "mako".source = lib'.mkDotfile "mako";
    "uwsm".source = lib'.mkDotfile "uwsm";
    "walker".source = lib'.mkDotfile "walker";
    "waybar".source = lib'.mkDotfile "waybar";
  };
}
