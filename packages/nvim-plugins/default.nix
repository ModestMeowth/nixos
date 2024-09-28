{pkgs, callPackage}: let
  sourceData = callPackage ../_sources/generated.nix {};
in {
  yaml-companion = pkgs.vimUtils.buildVimPlugin {
    inherit (sourceData.yaml-companion) pname src;
    version = sourceData.yaml-companion.date;
  };
}
