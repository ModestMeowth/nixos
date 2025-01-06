{ callPackage, pkgs, ... }:
let
  sourceData = callPackage ./_sources/generated.nix { };
  scriptName = "zfs-rebalance";
  deps = [ pkgs.perl ];
  scriptSrc = sourceData.zfs-inplace-rebalancing."zfs-inplace-rebalancing.sh";
  script = (pkgs.writeScriptBin "zfs-rebalance" (
    builtins.replaceStrings [ "zfs-inplace-rebalancing" ] [ "zfs-rebalance" ] scriptSrc
  )).overrideAttrs (old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
in
pkgs.symlinkJoin {
  name = scriptName;
  paths = [ script ] ++ deps;
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram $out/bin/${scriptName} --prefix PATH : $out/bin";
}
