{ config, inputs, ... }:
let
  inherit (builtins) attrNames;
  inherit (inputs.nixpkgs.lib) forEach mergeAttrsList;

  allHosts = (config.flake.nixosConfigurations // config.flake.darwinConfigurations);
in
{
  mkHomeConfigsForUser =
    user:
    mergeAttrsList (
      forEach (attrNames allHosts) (host: {
        "${user}-${host}".nameFunction = (_: "${user}@${host}");
      })
    );
}
