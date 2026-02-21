{ config, pkgs, ... }:
{
  # puts extra config which invalidates the config
  catppuccin.helix.enable = false;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      harper
      markdown-oxide
      nixd
    ];

    extraConfig = ''
      theme = "catppuccin_${config.catppuccin.flavor}"
    ''
    + builtins.readFile ../dotfiles/helix/config.toml;
  };
}
