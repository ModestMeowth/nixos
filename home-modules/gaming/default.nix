{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (lib) literalExpression mkEnableOption mkOption;

  inherit (lib.types) bool submodule;

  gamingOption = desc: {
    options = {
      enable = mkEnableOption desc;
      flatpak = mkOption {
        type = bool;
        description = "Use flatpak instead of nixpkgs";
        default = config.services.flatpak.enable;
        defaultText = literalExpression "config.services.flatpak.enable";
      };
    };
  };
in
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./azahar.nix
    ./bottles.nix
    ./dolphin.nix
    ./gamescope.nix
    ./lutris.nix
    ./pcsx2.nix
    ./retroarch.nix
    ./rpcs3.nix
    ./steam.nix
    ./wine.nix
  ];

  options.gaming = {
    azahar = mkOption { type = submodule (gamingOption "azahar"); };

    bottles = mkOption { type = submodule (gamingOption "bottles"); };

    dolphin = mkOption { type = submodule (gamingOption "dolphin"); };

    lutris = mkOption { type = submodule (gamingOption "lutris"); };

    pcsx2 = mkOption { type = submodule (gamingOption "PCSX2"); };

    retroarch = mkOption { type = submodule (gamingOption "retroarch"); };

    rpcs3 = mkOption { type = submodule (gamingOption "rpcs3"); };

    steam = mkOption { type = submodule (gamingOption "steam"); };

    wine = mkOption { type = submodule (gamingOption "wine"); };
  };
}
