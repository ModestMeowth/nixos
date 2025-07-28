{ pkgs, ... }: {
  imports = [ ./console.nix ./editor.nix ];

  environment.systemPackages = with pkgs; [
    bat
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
