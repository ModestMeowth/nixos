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
          nixd
          nixf
          # config.formatter
        ];
      };
    };
}
