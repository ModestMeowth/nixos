{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.shell.fish.plugins.fzf;
in
{
  options.modules.shell.fish.plugins.fzf.enable = mkEnableOption "fish-fzf";

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    programs.fish.plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];

    programs.fish.interactiveShellInit = # fish
      ''
        set fzf_preview_dir_cmd eza --always --color=always
        set -x FZF_DEFAULT_OPTS --color="fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4" --cycle --layout-reverse --border --height=90% --preview-window=wrap --marker="*"
      '';

    programs.fzf.enable = true;
    programs.fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/*"
        "*.bak"
      ];
    };
  };
}
