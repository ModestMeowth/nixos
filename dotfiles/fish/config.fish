status is-interactive; and begin
    set -g fish_greeting
    fish_config theme choose "Dracula"

    if type -q starship
        starship init fish | source
        enable_transience
    end

    if type -q direnv
        direnv hook fish | source
    end

    if type -q zoxide
        abbr --add -- cd z
        abbr --add -- ci zi

        zoxide init fish | source
    end

    if type -q just
        abbr --add -- j just
        set -gx JUST_UNSTABLE "true"
    end

    if  type -q eza
        abbr --add -- ls "eza"
        abbr --add -- la "eza -a"
        abbr --add -- ll "eza -l"
        abbr --add -- lla "eza -la"
        abbr --add -- lt "eza --tree"
    end

    if type -q mosh
        abbr --add -- ssh mosh
    end

    if type -q fzf
        fzf --fish | source
        set fzf_preview_dir_cmd exa --icons=auto --color=always
        set -gx FZF_DEFAULT_OPTS "--cycle --layout=reverse --border --height=90% --marker=* --color bg:#282a36,bg+:#44475a,fg:#f8f8f2,fg+:#f8f8f2,header:#6272a4,hl:#bd93f9,hl+:#bd93f9,info:#ffb86c,marker:#ff79c6,pointer:#ff78c6,prompt:#50fa7b,spinner:#ffb86c"
    end

    if type -q rga
        abbr --add -- rg "rga"
    end

    for dir in bin .bin .local/bin
        if test -d "$HOME/$dir"
            fish_add_path -P -p "$HOME/$dir"
        end
    end
end
