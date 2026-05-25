{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.partitions ];

  partitions.dev = {
    module = ./dev;
    extraInputsFlake = ./dev;
  };

  partitionedAttrs = lib.genAttrs [ "devShells" "formatter" ] (_: "dev");
}
