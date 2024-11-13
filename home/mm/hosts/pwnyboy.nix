{ inputs
, lib
, pkgs
, ...
}:
with lib;
{
  programs.neovim.enable = true;
  programs.gh.enable = true;

  home.packages = with pkgs; [
    commitizen
    nh
    nvfetcher
  ];

  home.file."justfile".text = mkForce # just
    ''
      @default:
        just --choose --justfile {{ justfile() }}

      system-update:
        sudo nala update
        sudo nala upgrade

      home-update:
        nh home switch "github:ModestMeowth/nixos" -- --refresh

      update: system-update home-update
    '';
}
