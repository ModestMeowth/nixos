{ pkgs, ... }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    just
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
