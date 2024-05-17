{pkgs, ...}: {
  programs = {
    fish = {
      plugins = with pkgs.fishPlugins; [
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
      ];

      interactiveShellInit = /*fish*/ ''
        if type -q eza
          set fzf_preview_dir_cmd eza --all --color=always
        end
        set -x FZF_DEFAULT_OPTS (echo \
          --color="fg:#f8f8f2,bg:#282a36,hl:#bd93f9"" \
          --color="fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9"" \
          --color="info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6" \
          --color="marker:#ff79c6,spinner:#ffb86c,header:#6272a4" \
          --cycle \
          --layout=reverse \
          --border \
          --height=90% \
          --preview-window=wrap \
          --marker="*")
      '';
    };

    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/*"
        "*.bak"
      ];
    };
    fzf.enable = true;
  };
}
