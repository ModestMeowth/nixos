{
  config,
  ezModules,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.strings)
    stringLength
    substring
    toUpper
    ;

  HOME = config.home.homeDirectory;
  cap = str: toUpper (substring 0 1 str) + substring 1 (stringLength str) str;
  flavor = config.catppuccin.flavor;
  monoFont = config.stylix.fonts.monospace.name;
  emojiFont = config.stylix.fonts.emoji.name;
in
{
  imports = [
    ezModules.chromium
  ];
  home.packages = with pkgs; [
    bitwarden-desktop
    imv
    google-chrome
    libnotify
    mpv
    signal-desktop
    rpi-imager
  ];

  catppuccin.ghostty.enable = false;
  programs.ghostty.enable = true;
  xdg.configFile."ghostty/config".text = ''
    theme = Catppuccin ${cap flavor}
    font-family = ${monoFont}
    font-family = ${emojiFont}
  ''
  + builtins.readFile ../dotfiles/ghostty/config;

  services = {
    udiskie = {
      enable = true;
      settings.program_options = {
        file_manager = "${config.programs.ghostty.package}/bin/ghostty -e ${config.programs.yazi.package}/bin/yazi";
      };
    };
  };

  stylix = {
    cursor = {
      name = "Catppuccin Macchiato Mauve";
      package = pkgs.catppuccin-cursors.macchiatoMauve;
      size = 24;
    };

    polarity = "dark";

    targets = {
      gnome.enable = true; # Needed to set system to dark mode default
      gtk.enable = true;
      kde.enable = true;
      qt.enable = true;
      font-packages.enable = lib.mkForce true;
    };
  };

  xdg.configFile = {
    "nebula.jpeg".source = ../dotfiles/wallpaper/nebula.jpeg;
    "Cat.png".source = ../dotfiles/wallpaper/Cat.png;
    "dark-cat-rosewater.png".source = ../dotfiles/wallpaper/dark-cat-rosewater.png;
    "face.png".source = ../dotfiles/wallpaper/face.png;
  };

  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "com.mitchellh.ghostty.desktop" ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = null;
    templates = null;
    publicShare = null;

    extraConfig = {
      SCREENSHOT_DIR = "${HOME}/Pictures/Screenshots";
      SCREENRECORD_DIR = "${HOME}/Videos/Screencasts";
    };
  };
}
