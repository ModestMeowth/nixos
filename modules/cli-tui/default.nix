{ pkgs, ... }: {
  imports = [ ./editors.nix ];

  environment.systemPackages = with pkgs; [
    bat
    bat-extras.batman
    bat-extras.batdiff
    bat-extras.prettybat
    btop
    curl
    diff-so-fancy
    direnv
    eza
    fd
    fzf
    gh
    git
    just
    jq
    killall
    nix-direnv
    ripgrep
    ripgrep-all
    starship
    tmux
    unzip
    wget
    zip
    zoxide

    treefmt
    nixfmt
    yamlfmt
    taplo
  ];
}
