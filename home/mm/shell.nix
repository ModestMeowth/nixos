{
  inputs,
  pkgs,
  myPkgs,
  ...
}:
{
  programs.fish.enable = true;

  programs.fish.plugins = with pkgs.fishPlugins; [
    {
      name = "puffer";
      src = puffer.src;
    }
    {
      name = "fzf-fish";
      src = fzf-fish.src;
    }
    {
      name = "abbreviation-tips";
      src = myPkgs.fish-plugins.abbreviation-tips.src;
    }
  ];

  programs.fish.interactiveShellInit = # fish
    ''
      set -g fish_greeting
      set fzf_preview_dir_cmd eza --always --color=always
      set -x FZF_DEFAULT_OPTS --color="fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4" --cycle --layout-reverse --border --height=90% --preview-window=wrap --marker="*"
      fish_vi_key_bindings

      if not string match -qi "vscode" $TERM_PROGRAM
        set ZELLIJ_AUTO_ATTACH true
        set ZELLIJ_AUTO_EXIT true
      end
    '';

  programs.fish.shellAbbrs = {
    ssh = "mosh";
    j = "just";

    # git
    g = "git";
    ga = "git add";
    clone = "git clone";
    co = "git switch";
    cz = "git cz c";

    # eza
    ls = "eza --icons --sort=type";
    ll = "eza lg --icons --sort=type";
    la = "eza -lag --icons --sort=type";
    tree = "eza --icons --tree";

    # zoxide
    cd = "z";
    ci = "zi";
  };

  programs.direnv.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;

  programs.fzf.enable = true;
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [
      ".git/*"
      "*.bak"
    ];
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
  };
  xdg.configFile."starship.toml".source = "${inputs.mm.outputs.dotfiles}/dot_config/starship.toml.tmpl";

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
  };
  xdg.configFile = {
    "zellij/config.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/config.kdl";
    "zellij/layouts/default.kdl".source = "${inputs.mm.outputs.dotfiles}/dot_config/zellij/layouts/default.kdl";
    "zellij/themes/dracula.kdl".source = "${inputs.dracula.outputs.zellij}";
  };
}
