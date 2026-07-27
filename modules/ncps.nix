{ den, lib, ... }:
{
  den.aspects.ncps = {
    includes = [ den.aspects.postgres ];

    nixos =
      { config, ... }:
      let
        cfg = config.services.ncps;
        port = 8501;
      in
      {
        nixpkgs.overlays = [
          (_final: prev: {
            ncps = prev.ncps.overrideAttrs (old: {
              src = old.src.overrideAttrs {
                tag = "v0.10.0-rc16";
                hash = "sha256-b8cYpPkJYmt0WJiTtuSsNqbGKViok6zPHpQHTBc9wZc=";
              };
              vendorHash = "sha256-vhwuUkqU9oWHtKT3BELa1v+QPmYsw+11AK/1KMtO9l0=";
              postInstall = ''
                mkdir -p $out/share/ncps
                wrapProgram $out/bin/ncps --set XZ_BINARY_PATH ${prev.lib.getExe' prev.xz "xz"}
              '';
              doCheck = false;
            });
          })
        ];

        systemd.services.ncps.preStart = lib.mkForce ''
          ${lib.getExe cfg.package} migrate up --cache-database-url ${cfg.cache.databaseURL}
        '';

        services = {
          ncps = {
            enable = true;
            cache = {
              hostName = lib.mkDefault config.networking.hostName;
              databaseURL = "postgresql://ncps@/ncps";

              upstream = {
                urls = [
                  "https://catppuccin.cachix.org"
                  "https://cache.nixos-cudo.org"
                  "https://nix-community.cachix.org"
                  "https://cache.nixos.org"
                ];

                publicKeys = [
                  "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
                  "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                ];
              };

              maxSize = "100G";
              lru.schedule = "0 2 * * *";
            };

            server.addr = "0.0.0.0:${toString port}";
          };

          postgresql = {
            ensureDatabases = [ "ncps" ];
            ensureUsers = [
              {
                name = "ncps";
                ensureDBOwnership = true;
              }
            ];
          };
        };

        networking.firewall.allowedTCPPorts = [ port ];
      };
  };
}
