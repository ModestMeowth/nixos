{ callPackage, stdenvNoCC, ... }:
let
  sourceData = callPackage ./_sources/generated.nix { };
in
{
  k9s = stdenvNoCC.mkDerivation {
    inherit (sourceData.dracula-k9s) pname src version;
    theme = sourceData.dracula-k9s."skins/dracula.yaml";
  };

  sublime = stdenvNoCC.mkDerivation {
    inherit (sourceData.dracula-sublime) pname src version;
    theme = sourceData.dracula-sublime."Dracula.tmTheme";
  };

  wezterm = stdenvNoCC.mkDerivation {
    inherit (sourceData.dracula-wezterm) pname src version;
    theme = sourceData.dracula-wezterm."dracula.toml";
  };

  zellij = stdenvNoCC.mkDerivation {
    inherit (sourceData.dracula-zellij) pname src version;
    theme = sourceData.dracula-zellij."dracula.kdl";
  };
}
