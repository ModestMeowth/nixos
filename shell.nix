{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    just
    nh
    sops

    treefmt

    # LSPs
    bash-language-server
    fish-lsp
    hyprls
    nixd
    taplo
    yamlfmt
  ];
}
