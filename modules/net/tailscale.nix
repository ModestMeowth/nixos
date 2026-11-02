{
  den.aspects.net = {
    nixos =
      { config, lib, ... }:
      let
        inherit (lib) mkIf mkDefault;
        secrets = config.sops.secrets;
        flags = [
          "--ssh"
          "--operator=mm"
        ];
      in
      {
        services.tailscale = {
          enable = true;
          authKeyFile = mkIf (builtins.hasAttr "tskey" secrets) secrets."tskey".path;
          extraUpFlags = mkDefault (flags ++ [ "--reset" ]);
          extraSetFlags = mkDefault flags;
          openFirewall = true;
          useRoutingFeatures = mkDefault "client";
        };
      };
  };
}
