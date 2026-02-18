{ config, pkgs, ... }:
{
  # puts extra config which invalidates the config
  catppuccin.helix.enable = false;

  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
    defaultEditor = true;
    extraPackages = with pkgs; [
      bash-language-server
      fish-lsp
      markdown-oxide
      nixd
      taplo
      vscode-css-languageserver
      yamlfmt
    ];

    extraConfig = ''
      theme = "catppuccin_${config.catppuccin.flavor}"
    ''
    + builtins.readFile ../dotfiles/helix/config.toml;
  };
}
