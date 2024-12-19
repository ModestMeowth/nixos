{callPackage, pkgs, ...}: let
  sourceData = callPackage ./_sources/generated.nix {};
  inherit (sourceData.zfs-inplace-rebalancing) pname src version;
in
{
  zfs-inplace-rebalancing = (pkgs.writeScriptBin "zfs-rebalance" sourceData."zfs-inplace-rebalancing.sh").overrideAttrs(old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
}
