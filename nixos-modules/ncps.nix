{config, lib, ...}:
let
  port = 8501;
in
{
  services = {
    ncps = {
      enable = true;

      cache = {
        hostName = lib.mkDefault config.networking.hostName;
        databaseURL = "postgresql://ncps@localhost:5432/ncps?sslmode=require";

        allowPutVerb = true;
        allowDeleteVerb = true;

        lru.schedule = "0 2 * * *";
      };

      server.addr = "0.0.0.0:${port}";

      upstream = {
        caches = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://lanzaboote.cachix.org"
          "https://hyprland.cachix.org"
          "https://catppuccin.cachix.org"
        ];

        publicKeys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        ];
      };
    };

    postgresql = {
      enable = true;
      ensureDatabases = [ "ncps" ];
      ensureUsers = [{
        name = "ncps";
        ensureDBOwnership = true;
      }];
    };
  };

  networking.firewall.allowedTCPPorts = [ port ];
}
