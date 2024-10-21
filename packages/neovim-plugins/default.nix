{ pkgs, callPackage }:
let
  sourceData = callPackage ../_sources/generated.nix { };
in
{
  yaml-companion-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sourceData.yaml-companion-nvim) pname src;
    version = sourceData.yaml-companion-nvim.src.rev;
  };
}
