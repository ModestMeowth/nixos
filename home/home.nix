{ config, lib, pkgs, ... }: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/${path}";
  HOME = config.home.homeDirectory;
in {
  imports = [ ./emacs.nix ./neovim.nix ];

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

  services.syncthing.enable = true;

  home.file = {
    ".editorconfig".source = mkSymlink "editorconfig/editorconfig";
    ".local/bin".source = mkSymlink "bin";
    ".tmux.conf".source = mkSymlink "tmux/tmux.conf";
  };

  xdg.configFile = {
    "doom".source = mkSymlink "doom";
    "bat".source = mkSymlink "bat";
    "btop/btop.conf".source = mkSymlink "btop/btop.conf";
    "git".source = mkSymlink "git";
    "fish/localconfig.fish".source = mkSymlink "fish/config.fish";
    "nvim".source = mkSymlink "nvim";
    "starship.toml".source = mkSymlink "starship/starship.toml";
  };
}
