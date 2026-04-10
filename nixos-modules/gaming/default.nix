{lib, ...}:
let
  inherit (lib) mkEnableOption;
in
{
  options.gaming = {
    emulation = mkEnableOption "emulation";
    ffxiv = mkEnableOption "ffxiv";
    gamescope = mkEnableOption "gamescope";
    steam = mkEnableOption "steam";
    wine = mkEnableOption "wine";
  };

  imports = [
    ./emulation.nix
    ./ffxiv.nix
    ./gamemode.nix
    ./gamescope.nix
    ./steam.nix
    ./wine.nix
  ];
}
