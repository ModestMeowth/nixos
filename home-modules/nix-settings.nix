{ pkgs, ... }:
{
  nix = {
    package = pkgs.nix;
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "pwnyboy";
        sshUser = "mm";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      }
    ];

    settings = {
      experimental-features = "nix-command flakes";

      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      substituters = [
        "http://pwnyboy:8501?priority=1"
        "https://nix-community.cachix.org?priority=30"
        "https://cache.nixos.org?priority=40"
      ];

      extra-substituters = [
        "https://catppuccin.cachix.org?priority=11"
      ];

      trusted-public-keys = [
        "pwnyboy:GonEZtCkw+aFq6oHxKN7SB8y6p8NSkDuRsadSyZ0NuA="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      extra-trusted-public-keys = [
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}
