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

  # Browsers
  programs = {
    firefox = {
      package = pkgs.unstable.firefox;
      profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };

    chromium = {
      package = (pkgs.unstable.chromium.override {
        commandLineArgs = [
          "--enable-features=Vulkan"
        ];
        enableWideVine = true;
      });
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock
      ];
    };
  };

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "bat".source = mkSymlink "bat";
    "btop/btop.conf".source = mkSymlink "btop/btop.conf";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
