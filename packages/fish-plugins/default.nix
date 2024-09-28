{callPackage, buildFishPlugin}: let
  sourceData = callPackage ../_sources/generate.nix {};
in {
  abbreviation-tips = buildFishPlugin {
    inherit (sourceData.abbreviation-tips) pname src version;
  };
}
