{
  den,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  systems = lib.attrNames den.hosts;
}
