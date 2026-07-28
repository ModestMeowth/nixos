{
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          deploy-rs
          nh
          sops
          just
          nix-unit

          # lSPs
          fish-lsp
          kdePackages.qtdeclarative # qmlls
          lua-language-server
          nixd
          nixf
          taplo
          vscode-json-languageserver
          yaml-language-server

          # config.formatter
        ];
      };
    };
}
