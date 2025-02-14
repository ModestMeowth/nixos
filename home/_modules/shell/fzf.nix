{ config, lib, ... }:
let
  cfgBash = config.programs.bash;
  cfgFish = config.programs.fish;
  cfgFzf = config.programs.fzf;
in
{
  programs.bash = lib.mkIf (cfgFzf.enable && cfgBash.enable) {
    initExtra = # bash
      ''
        export FZF_DEFAULT_OPTS=--color="fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4" --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"
      '';
  };

  programs.fish = lib.mkIf (cfgFzf.enable && cfgFish.enable) {
    interactiveShellInit = # fish
      ''
        set fzf_preview_dir_cmd eza --always --color=always
        set -x FZF_DEFAULT_OPTS --color="fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4" --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"
      '';
  };
}
