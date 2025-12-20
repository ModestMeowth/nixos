{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    bat-extras.batman
    bat-extras.batdiff
    bat-extras.prettybat
    curl
    diff-so-fancy
    direnv
    eza
    fd
    fzf
    gh
    git
    htop
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

  programs = {
    htop.enable = true;

    vim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
