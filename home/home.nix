{ config, lib, pkgs, ... }: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
  HOME = config.home.homeDirectory;
in {
  imports = [ ./neovim ];

  xdg.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.mkAfter # fish
      ''
        source ${HOME}/.config/fish/localconfig.fish
      '';
  };

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "bat".source = mkSymlink "bat";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "starship.toml".source = mkSymlink "starship/starship.toml";
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
