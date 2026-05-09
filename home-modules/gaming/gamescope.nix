{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.services.flatpak;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  nixpkgs.overlays = [
    (final: _: {
      scopebuddy = inputs.scopebuddy.packages.${system}.default;
    })
  ];

  home.packages = [ pkgs.scopebuddy ];

  services.flatpak.packages = lib.mkIf cfg.enable [
    "org.freedesktop.Platform.VulkanLayer.gamescope//25.08"
  ];
}
