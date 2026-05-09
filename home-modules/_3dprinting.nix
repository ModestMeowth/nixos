{config, inputs, lib, pkgs, ...}:
let
  cfg = config.services.flatpak;
in
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.packages = lib.mkIf cfg.enable [
    "com.bambulab.BambuStudio"
  ];

  home.packages = lib.mkIf (!cfg.enable) [ pkgs.bambu-studio ];
}
