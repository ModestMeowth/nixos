{ den, inputs, ...}:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  flake.den = den;
}
