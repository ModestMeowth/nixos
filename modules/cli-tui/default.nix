{ pkgs, ... }: {
  imports = [ ./editor.nix ];

  environment.systemPackages = with pkgs; [
    bat
    direnv
    curl
    eza
    fd
    fzf
    gh
    git
    just
    jq
    killall
    ripgrep-all
    starship
    tmux
    unzip
    wget
    zip
    zoxide
  ];
}
