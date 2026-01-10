{ config, pkgs, ... }:
let
  mkSymlink = p:
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${p}";
in {
  home.packages = with pkgs; [
    bitwarden-desktop
    unstable.bootdev-cli
    unstable.google-chrome
    virt-manager ];

  programs = {
    ghostty.enable = true;
    # firefox.enable = true;
    #chromium.enable = true;
  };

  services.syncthing.enable = true;

  xsession.enable = true;

  home.file = {
    ".local/bin/powermenu".source = mkSymlink "bin/powermenu";
    ".local/bin/toggle-dnd".source = mkSymlink "bin/toggle-dnd";
    ".local/bin/toggle-idle".source = mkSymlink "bin/toggle-idle";
  };

  xdg.configFile = {
    "nebula.jpeg".source = mkSymlink "wallpaper/nebula.jpeg";
    "Cat.png".source = mkSymlink "wallpaper/Cat.png";
    "dark-cat-rosewater.png".source = mkSymlink "wallpaper/dark-cat-rosewater.png";
    "face.png".source = mkSymlink "wallpaper/face.png";
    "ghostty".source = mkSymlink "ghostty";
    "hypr".source = mkSymlink "hypr";
    "mako".source = mkSymlink "mako";
    "uwsm".source = mkSymlink "uwsm";
    "walker".source = mkSymlink "walker";
    "waybar".source = mkSymlink "waybar";
  };

  gtk.iconTheme = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
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
      serif = {
        name = "0xProto Nerd Font Propo";
        package = pkgs.nerd-fonts._0xproto;
      };
      sansSerif = {
        name = "Caskaydia Cove Nerd Font";
        package = pkgs.nerd-fonts.caskaydia-cove;
      };
      monospace = {
        name = "0xProto Nerd Font Mono";
        package = pkgs.nerd-fonts._0xproto;
      };
      emoji = {
        name = "Noto-Color-Emoji";
        package = pkgs.nerd-fonts.noto;
      };
    };

    targets.gtk = {
      enable = true;
      colors.enable = true;
      fonts.enable = true;
    };
  };
}
