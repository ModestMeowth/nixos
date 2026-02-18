{ pkgs, ... }:
pkgs.mkShell {
  builtInputs = with pkgs; [
    just
    treefmt

    # LSPs for helix
    bash-language-server
    fish-lsp
    nixd
    taplo
    yamlfmt
  ];
}
