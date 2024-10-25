{ callPackage, stdenvNoCC, ... }:
let
  sourceData = callPackage ./_sources/generated.nix { };
in
stdenvNoCC.mkDerivation { inherit (sourceData.keys) pname version src; }
